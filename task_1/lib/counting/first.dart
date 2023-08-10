import 'dart:io';

Future<int> countLinesInFile(String filePath) async {
  File file = File(filePath);

  if (!file.existsSync()) {
    return 0; // Файл не существует, возвращаем 0 строк
  }

  List<String> lines = await file.readAsLines();
  return lines.length;
}

void createFile(String filePath, String content) {
  File file = File(filePath);

  file.writeAsStringSync(content);

  print('File created: $filePath');
}

void main() async {
  String filePath = 'first.dart';
  final int count = await countLinesInFile(filePath);
  String genfilePath = '../generated/summary.g';

  String fileContent = 'Length of $filePath = $count';

  createFile(genfilePath, fileContent);
}
