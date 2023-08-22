// tool/json_generator.dart

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sourceg/visitor.dart';

import 'annotations.dart';

class SerilGenerator extends GeneratorForAnnotation<Seril> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print('Generator elem: ');
    print(element);
    final visitor = Visitor();
    element.visitChildren(visitor);

    var buffer = StringBuffer();

    String className = visitor.className;
    var data = visitor.printData;
    var types = visitor.dataTypes;
    print('----------> ');
    //print(visitor.className);

    //print(visitor.printData.keys);

    //data.keys.forEach((element) => print(data[element]));
    /// FromJson
    types.keys.forEach((element) => print(types[element]));
    print('<---------- ');
    buffer.writeln("""
      $className _\$$className\FromJson(Map<String, dynamic> json) => $className(""");

    data.keys.forEach((element) {
      buffer.writeln("""
        ${data[element]}: json['${data[element]}'] as ${types[element]},
                    """);
    });
    buffer.writeln(");");

    /// ToJson
    buffer.writeln("""
     Map<String, dynamic> _\$${className}ToJson($className instance) => {""");

    data.keys.forEach((element) {
      buffer.writeln("""
    '${data[element]}': instance.$element.toString(),
                    """);
    });

    buffer.writeln("};");
    return buffer.toString();
  }
}
