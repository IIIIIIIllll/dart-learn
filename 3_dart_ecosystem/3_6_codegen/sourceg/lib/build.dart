import 'package:sourceg/json_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

Builder generate(BuilderOptions options) =>
    SharedPartBuilder([SerilGenerator()], 'generator');
