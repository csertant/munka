import 'package:material_ui/material_ui.dart';

import '../../core/themes/dimensions.dart';

class SettingsRadioGroup<T> extends StatelessWidget {
  const SettingsRadioGroup({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.optionLabels,
    required this.selectedOption,
    required this.onChanged,
  }) : assert(
         options.length == optionLabels.length,
         'Options and option labels must have the same length',
       );

  final String title;
  final String subtitle;
  final List<T> options;
  final List<String> optionLabels;
  final T selectedOption;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
      ),
      child: RadioGroup<T>(
        onChanged: onChanged,
        groupValue: selectedOption,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            Text(subtitle, style: theme.textTheme.bodyMedium),
            const SizedBox(height: AppDimensions.paddingSmall),
            ...options.map(
              (option) => RadioListTile<T>(
                contentPadding: EdgeInsets.zero,
                value: option,
                title: Text(optionLabels[options.indexOf(option)]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
