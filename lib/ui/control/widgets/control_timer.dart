import 'package:material_ui/material_ui.dart';

import '../../../utils/utils.dart';
import '../../core/themes/dimensions.dart';
import '../control_viewmodel.dart';

class ControlTimer extends StatelessWidget {
  const ControlTimer({super.key, required this.viewModel});

  final ControlViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingExtraLarge),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '@${viewModel.profileId ?? ''}',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onTertiary,
                  ),
                ),
                Text(
                  viewModel.isTracking.value
                      ? AppDateUtils.formatElapsedTime(viewModel.elapsed)
                      : AppDateFormat.HHmm.format(viewModel.currentTime),
                  style: theme.textTheme.headlineLarge,
                ),
                Text(
                  AppDateFormat.yMMdd.format(viewModel.currentTime),
                  style: theme.textTheme.titleLarge,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
