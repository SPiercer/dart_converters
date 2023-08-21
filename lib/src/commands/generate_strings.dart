import 'dart:convert';
import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';

class GenerateStrings extends Command {
  @override
  String get description => "Convert text widget strings to arb format";

  @override
  String get name => "generateStrings";

  @override
  String get invocation => "generateStrings <file_path> [flags]";

  GenerateStrings() {
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
    final arbMap = <String, String>{};

    final list =
        Directory(filePath).listSync(recursive: true, followLinks: false);

    for (var file in list) {
      if (file is File && file.path.endsWith('.dart')) {
        final fileContent = await file.readAsString();

        final pattern =
            RegExp(r"(?<=Text\(\n\s+')\w.+(?=')|(?<=Text\(').*(?=')");

        final matches = pattern.allMatches(fileContent);

        for (var match in matches) {
          final key = match.group(0)!;
          if (key.contains(r"$")) continue;
          final lowerCamelCaseKey = ReCase(key).camelCase;

          arbMap[lowerCamelCaseKey] = key;

          if (argResults!['apply'] as bool) {
            final newText = 'context.tr.$lowerCamelCaseKey';
            final oldText = key;
            final newFileContent =
                fileContent.replaceAll("'$oldText'", newText);
            await file.writeAsString(newFileContent);
          }
        }
      }
    }
    final prettyJson = JsonEncoder.withIndent('  ');
    if (!argResults!['apply']) {
      print('This is a dry run to apply use --apply flag, result is:\n');
      print(prettyJson.convert(arbMap) + '\n');
      print('This was a dry run to apply use --apply flag\n');
    } else {
      print(prettyJson.convert(arbMap) + '\n');
      print('⚡ converted with love <3 by dart_converters ⚡');
    }
    return;
  }
}
