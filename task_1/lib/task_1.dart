/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'dart:io';

export 'src/un.dart';
import 'package:build/build.dart';

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

  if (!file.existsSync()) {
    file.writeAsStringSync(content);
  }

  file.writeAsStringSync(content, mode: FileMode.append);

  print('File created: $filePath');
}

class CodeLinesBuilder extends Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.dart.g']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    // Each `buildStep` has a single input.
    var inputId = buildStep.inputId;
    print(inputId.path);
    // Create a new target `AssetId` based on the old one.

    // Write out the new asset.
    //await buildStep.writeAsString(copy, contents);

    final int count = await countLinesInFile(inputId.path);
    String sumFilePath = 'lib/generated/summary.g';
    String fileContent = 'Length of ${inputId.path} = $count \n';

    createFile(sumFilePath, fileContent);
  }
}

Builder codeLineBuilder(BuilderOptions options) => CodeLinesBuilder();
