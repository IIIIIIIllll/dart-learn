extension DateTimeExtension on DateTime {
  String formatDateTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    
    String year = this.year.toString();
    String month = twoDigits(this.month);
    String day = twoDigits(this.day);
    String hour = twoDigits(this.hour);
    String minute = twoDigits(this.minute);
    String second = twoDigits(this.second);
    
    return '$year.$month.$day $hour:$minute:$second';
  }
}
void main() {
  DateTime currentTime = DateTime.now();
  String formattedDateTime = currentTime.formatDateTime();
  
  print(formattedDateTime); // Output: 2023.01.01 00:00:00
}
