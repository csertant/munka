import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';

import '../themes/dimensions.dart';

abstract class CustomIcons {}

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.iconPath,
    this.size,
    this.color,
    this.padding,
  });

  final String iconPath;
  final double? size;
  final Color? color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = this.size ?? AppDimensions.of(context).iconSizeDefault;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SvgPicture.asset(
        iconPath,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(
          color ?? theme.colorScheme.outline,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
