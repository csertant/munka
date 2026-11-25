import 'package:fl_chart/fl_chart.dart';
import 'package:material_ui/material_ui.dart';

import '../../../domain/models/models.dart';
import '../../core/themes/dimensions.dart';

class StatsChart extends StatelessWidget {
  const StatsChart({
    super.key,
    required this.buckets,
    required this.stepBackward,
    required this.stepForward,
    required this.granularity,
    required this.maxHours,
  });

  final List<StatsBucket> buckets;
  final VoidCallback stepBackward;
  final VoidCallback stepForward;
  final StatsGranularity granularity;
  final double maxHours;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: (details) {
        final velocity = details.primaryVelocity ?? 0;
        if (velocity > 150) {
          stepBackward.call();
        } else if (velocity < -150) {
          stepForward.call();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: BarChart(
          BarChartData(
            maxY: maxHours,
            minY: 0,
            gridData: const FlGridData(drawVerticalLine: false),
            borderData: FlBorderData(show: false),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipBorderRadius: const BorderRadius.all(
                  Radius.circular(AppDimensions.borderRadiusMedium),
                ),
                getTooltipColor: (group) {
                  return theme.colorScheme.outlineVariant;
                },
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final bucket = buckets[group.x];
                  return BarTooltipItem(
                    '${bucket.label}\n${bucket.hours.toStringAsFixed(2)} h',
                    theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.surface,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(),
              rightTitles: const AxisTitles(),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: AppDimensions.chartLeftTitlesSize,
                  getTitlesWidget: (value, meta) {
                    if (value == 0 || value == meta.max) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      '${value.toInt()} h',
                      style: theme.textTheme.bodySmall,
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: AppDimensions.chartBottomTitlesSize,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= buckets.length) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: AppDimensions.paddingSmall,
                      ),
                      child: Text(
                        buckets[index].label,
                        style: theme.textTheme.bodySmall,
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups: buckets
                .map(
                  (bucket) => BarChartGroupData(
                    x: bucket.index,
                    barRods: [
                      BarChartRodData(
                        toY: bucket.hours,
                        width: granularity == StatsGranularity.day
                            ? AppDimensions.chartBarWidthSingleColumn
                            : AppDimensions.chartBarWidth,
                        color: theme.colorScheme.onSecondary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(AppDimensions.borderRadiusMedium),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
