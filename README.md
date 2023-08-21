# Dart Converters

## A simple dart CLI to do various file conversion

---

Ever get tired from changing old code to follow the current standards
i.e snake_case to camelCase variable naming ?

i got the solution for you!

## introducing DART CONVERTERS

### List of Commands

- `snakeToCamel`
- `generateStrings`

## now break free from boring long tasks

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

and this

```dart
Text(
  'Hello World',
  style: TextStyle(
    color: Colors.black,
    fontSize: 16,
  ),
)
```

to this

```arb
{
  "helloWorld": "Hello World",
}
```

## Usage:

Pretty straight forward just add it using the activate command and you're ready to use it.

`dart pub global activate dart_converters`

`dart_converters snakeToCamel <file_path> --apply`

`dart_converters generateStrings <directory_path> --apply`

> Generate Strings will loop over all the dart files in the directory and generate a arb file for each string found in a Text widget
> Also note that it will only generates strings with no interpolation in them for now.

if you didn't add the `--apply` flag it will execute a dry run to preview the changes with no file modification

## Known Issues

> For some reason it misses some strings in the dart files, i'm still investigating the issue
> if you have any idea why this is happening please let me know
> but for now you can rerun the command and it will generate the missing strings or you can add them manually to the arb file
