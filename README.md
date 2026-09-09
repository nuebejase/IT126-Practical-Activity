# IT 126 Practical Activity — Petal Registration

Flutter registration form for **IT 126 Mobile Development**.

Student: **Jase Karl M. Zerrudo**

## What it does

- Collects first name, last name, email, password, and confirm password
- Validates every field before a successful registration
- Shows the submitted name and email (password stays hidden)
- Clears the form after a successful submit
- Uses a success dialog, password show/hide, live-disabled Register button, and tap-outside to close the keyboard

## How to run

1. Install [Flutter](https://docs.flutter.dev/get-started/install) (this machine already has it at `C:\Users\JASE KARL\flutter`)
2. From this folder:

```bash
flutter pub get
flutter run
```

Chrome, Windows, or an Android device/emulator all work. On Android, the project already uses `adjustResize` so the keyboard does not cover the form.

## Project layout

| Path | Role |
| --- | --- |
| `lib/main.dart` | `runApp` and `MaterialApp` |
| `lib/theme/app_theme.dart` | Pink and green theme |
| `lib/screens/registration_screen.dart` | Controllers, validation, keyboard, submit flow |
| `lib/validation/form_validators.dart` | Field rules |
| `lib/widgets/petal_text_field.dart` | Shared input widget |
| `lib/widgets/result_card.dart` | Successful result on screen |
| `lib/models/registration_result.dart` | Submitted data without password |


The 30-point code explanation is usually about *why* the widgets exist, not reciting every line.

1. **`StatefulWidget`** — the form keeps controllers, focus nodes, show/hide flags, and the last successful result. Those change while the app runs, so they live in `State`.
2. **`TextEditingController`** — showing a `TextFormField` is not the same as reading it. Controllers store the typed text; `dispose()` releases them.
3. **`Form` + `GlobalKey<FormState>`** — `validate()` runs every field validator. The success dialog only opens when that returns true.
4. **`setState`** — listeners on the controllers call `setState` so the Register button can turn on/off as the user types.
5. **Keyboard / overflow** — `resizeToAvoidBottomInset: true` plus `SingleChildScrollView` so the keyboard does not clip the form. `GestureDetector` unfocuses when you tap outside a field.
6. **Declarative UI** — after a successful submit, `_result` is set and the fields are cleared; `build()` describes the new screen. Flutter is not hunting an old `Text` widget to rewrite it.
