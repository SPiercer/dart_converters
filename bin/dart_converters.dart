import 'package:args/command_runner.dart';
import 'package:dart_converters/src/commands/generate_strings.dart';
import 'package:dart_converters/src/commands/snake_to_camel.dart';

Future<void> main(List<String> arguments) async {
  final runner = CommandRunner(
      'dart_converters', ' ⚡ : CLI to do various file conversions ⚡.');

  final commands = <Command>[
    SnakeToCamel(),
    GenerateStrings(),
  ];

  commands.forEach(runner.addCommand);
  await runner.run(arguments);
}
