import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

class Visitor extends SimpleElementVisitor<void> {
  String className = '';
  Map<String, String> printData = {};
  Map<String, String> dataTypes = {};

  @override
  void visitConstructorElement(ConstructorElement element) {
    print('Element: ');
    print(element);
    final elementReturnType = element.type.returnType.toString();
    className = elementReturnType.replaceFirst('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    print('Field: ');
    print(element.source);
    var instanceName = element.name;
    var instanceType = element.type.toString();

    printData[instanceName] = element.name;
    dataTypes[instanceName] = instanceType;
  }
}
