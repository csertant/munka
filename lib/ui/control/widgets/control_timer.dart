import 'package:material_ui/material_ui.dart';

import '../../../utils/utils.dart';
import '../../core/themes/dimensions.dart';

class ControlTimer extends StatelessWidget {
  const ControlTimer({
    super.key,
    required this.currentTime,
    this.elapsed,
    required this.isTracking,
  }) : assert(
         !isTracking || elapsed != null,
         'Elapsed time should not be null when tracking',
       );

  final DateTime currentTime;
  final Duration? elapsed;
  final bool isTracking;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingExtraLarge),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isTracking
                ? AppDateUtils.formatElapsedTime(elapsed!)
                : AppDateFormat.HHmm.format(currentTime),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            AppDateFormat.yMMdd.format(currentTime),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
