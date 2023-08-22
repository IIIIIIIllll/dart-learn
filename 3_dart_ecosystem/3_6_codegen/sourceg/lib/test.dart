import "package:sourceg/annotations.dart"; // аннотации из нашего пакета
import 'dart:core';

import 'package:sourceg/person.dart';

void main() {
  Person p = new Person(name: 'sasa', birthday: DateTime(2002));
}
