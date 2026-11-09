import 'package:material_ui/material_ui.dart';

import '../themes/dimensions.dart';
import 'custom_icon.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key, required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
      child: CustomIcon(iconPath: iconPath),
    );
  }
}
