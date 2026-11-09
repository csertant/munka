import 'package:material_ui/material_ui.dart';

import '../themes/dimensions.dart';

enum CustomAppBarType { image, text }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar.image({super.key, required this.imagePath})
    : type = CustomAppBarType.image,
      text = null;
  const CustomAppBar.text({super.key, required this.text})
    : type = CustomAppBarType.text,
      imagePath = null;

  final String? text;
  final String? imagePath;
  final CustomAppBarType type;

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final title = type == CustomAppBarType.image
        ? Image.asset(
            imagePath!,
            width: AppDimensions.appBarHeight - AppDimensions.paddingMedium,
            height: AppDimensions.appBarHeight - AppDimensions.paddingMedium,
          )
        : Text(this.text!);
    return AppBar(
      title: title,
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      centerTitle: true,
    );
  }
}
