part of 'widget_imports.dart';

Future<DateTime?> customDatePicker(
  BuildContext context,
  DateTime? selectedDate,
) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2019, 1),
    lastDate: DateTime(2050, 12),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(43, 136, 216, 1),
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      );
    },
  );

  return pickedDate;
}

Future<void> customDatePicker2(
  BuildContext context,
  Function(DateTime) onDateSelected, [
  DateTime? initialDate,
]) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: initialDate ?? DateTime.now(),
    lastDate: DateTime(2050, 12),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(43, 136, 216, 1),
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    onDateSelected(pickedDate); // Pass selected date to the callback function
  }
}
