import 'package:material_ui/material_ui.dart';

import '../../../utils/utils.dart';
import 'widgets.dart';

class CustomDateTimeField extends StatefulWidget {
  const CustomDateTimeField({
    super.key,
    this.initialValue,
    this.labelText,
    this.onChanged,
    this.required = false,
  });

  final DateTime? initialValue;
  final String? labelText;
  final ValueChanged<DateTime?>? onChanged;
  final bool required;

  @override
  State<CustomDateTimeField> createState() => _CustomDateTimeFieldState();
}

class _CustomDateTimeFieldState extends State<CustomDateTimeField> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialValue;
    if (_selectedDateTime != null) {
      _controller.text = AppDateFormat.yMMddHHmm.format(_selectedDateTime!);
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: AppDateUtils.firstPossibleDate(),
      lastDate: AppDateUtils.lastPossibleDate(),
    );
    if (pickedDate == null || !context.mounted) {
      return;
    }

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
    );
    if (pickedTime == null || !context.mounted) {
      return;
    }

    final combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    setState(() {
      _selectedDateTime = combined;
      _controller.text = AppDateFormat.yMMddHHmm.format(combined);
      widget.onChanged?.call(_selectedDateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      labelText: widget.labelText,
      required: widget.required,
      controller: _controller,
      keyboardType: TextInputType.none,
      onTap: () => _selectDateTime(context),
    );
  }
}
