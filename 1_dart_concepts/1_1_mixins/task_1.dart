extension StringParsing on DateTime {
    String parseString() {
      String s = toString();
      return s.substring(0, s.length - 4);
    }
  }

void main() {
  // Implement an extension on [DateTime], returning a [String] in format of
  // `YYYY.MM.DD hh:mm:ss` (e.g. `2023.01.01 00:00:00`).
  
  final date = DateTime.now();
  print(date.parseString());
}
