import 'package:material_ui/material_ui.dart';

import '../themes/dimensions.dart';
import 'custom_icon.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.iconPath,
    this.size,
    this.padding,
  });

  final String iconPath;
  final EdgeInsets? padding;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = this.size ?? AppDimensions.of(context).avatarSizeDefault;
    return Container(
      padding: padding ?? const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusFull),
      ),
      width: size,
      height: size,
      child: CustomIcon(iconPath: iconPath),
    );
  }
}
