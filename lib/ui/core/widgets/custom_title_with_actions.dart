import 'package:material_ui/material_ui.dart';

import '../themes/dimensions.dart';
import 'widgets.dart';

class CustomTitleWithActions extends StatelessWidget {
  const CustomTitleWithActions({
    super.key,
    required this.title,
    required this.actions,
  });

  final String title;
  final List<CustomIconButton> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Row(
        spacing: AppDimensions.paddingSmall,
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          ...actions,
        ],
      ),
    );
  }
}
