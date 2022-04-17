import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:dart_converters/src/config.dart';

class SnakeToCamel extends Command {
  @override
  String get description => "Convert snake_case to camelCase";

  @override
  String get name => "snakeToCamel";

  @override
  String get invocation => "snakeToCamel <file_path> [flags]";

  SnakeToCamel() {
    argParser
      ..addFlag(
        'dry',
        help: 'Dry run, doesn\'t write to file, preview only',
        defaultsTo: true,
        negatable: false,
      )
      ..addFlag(
        'apply',
        help: 'Apply changes to file',
        defaultsTo: false,
        negatable: false,
      );
  }

  @override
  Future<void> run() async {
    if (argResults!.arguments.isEmpty) {
      throw UsageException('No file path provided.', usage);
    }
    final filePath = argResults!.rest.first;
    final isDry = argResults!['dry'] as bool;

    final file = File(filePath);
    final fileContent = await file.readAsString();

    final higherToLowerSnakePattern =
        RegExp(r'(?:[^_](\S+?)_)[0-9A-Za-z]+(?:_[^_\n]+)*');
    final snakeToCamelPattern = RegExp(r'_([a-z])');

    final lowerSnakeCase = fileContent.replaceAllMapped(
        higherToLowerSnakePattern, (match) => match.group(0)!.toLowerCase());

    final camelCase = lowerSnakeCase.replaceAllMapped(
        snakeToCamelPattern, (match) => match.group(1)!.toUpperCase());
    if (isDry) {
      //print out this is dry and then result
      print('This is a dry run to apply use --apply flag, result is:\n');
      print(camelCase + '\n');
      print('This was a dry run to apply use --apply flag\n');
    } else {
      await file.writeAsString(kTopComment + "\n\n" + camelCase);
      print('⚡ converted with love <3 by dart_converters ⚡');
    }
    return;
  }
}
