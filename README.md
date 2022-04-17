# Dart Converters

## A simple dart CLI to do various file conversion
---

Ever get tired from changing old code to follow the current standards
i.e snake_case to camelCase variable naming ?

i got the solution for you!

## introducing DART CONVERTERS

### List of Commands
- `snakeToCamel`

acually there's no other command except this one currently lol
## but for now break free from boring long tasks 
with one command line you can change this

```dart
class Model {
  String? first_name;
  String? last_name;
  String? email_address;
  String? PHONE_NUMBER;
}
```
to this
```dart
class Model {
  String? firstName;
  String? lastName;
  String? emailAddress;
  String? phoneNumber;
}
```

## Usage:

Pretty straight forward just add it using the activate command and you're ready to use it.

`dart pub global activate dart_converters`


`dart_converters snakeToCamel <file_path> --apply`

if you didn't add the `--apply` flag it will execute a dry run to preview the changes with no file modification

### See also

## [Flutter Queen ](https://github.com/FlutterQueen)