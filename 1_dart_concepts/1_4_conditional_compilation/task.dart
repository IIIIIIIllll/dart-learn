import 'dart:io';


class CustomDateTime {
  late int year;
  late int month;
  late int day;
  late int hour;
  late int minute;
  late int second;
  late int microsecond;

  CustomDateTime({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
    required this.microsecond,
  });

  @override
  String toString() {
    return '$year-$month-$day $hour:$minute:$second.$microsecond';
  }
}

void main() {
  CustomDateTime dateTime;

  // Platform-specific implementation
  if (Platform.isAndroid || Platform.isIOS) {
    // Native implementation
    final now = DateTime.now();
    dateTime = CustomDateTime(
      year: now.year,
      month: now.month,
      day: now.day,
      hour: now.hour,
      minute: now.minute,
      second: now.second,
      microsecond: now.microsecond,
    );
  } else {
    
    // Web implementation
    dateTime = CustomDateTime(
      year: 2023,
      month: 6,
      day: 6,
      hour: 12,
      minute: 0,
      second: 0,
      microsecond: 10,
    );
  }

  print(dateTime);
}
