/// Field-level rules used by both [TextFormField.validator]
/// and the live "is the Submit button allowed?" check.
class FormValidators {
  static final RegExp _namePattern = RegExp(r"^[A-Za-z][A-Za-z\s\-']*$");
  static final RegExp _emailPattern = RegExp(
    r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
  );

  static String? firstName(String? value) => _personName(value, 'First name');

  static String? lastName(String? value) => _personName(value, 'Last name');

  static String? email(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Email is required';
    }
    if (!_emailPattern.hasMatch(text)) {
      return 'Enter a valid email, like name@gmail.com';
    }
    return null;
  }

  static String? password(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Password is required';
    }
    if (text.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Please confirm your password';
    }
    if (text != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static bool isFormValid({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return FormValidators.firstName(firstName) == null &&
        FormValidators.lastName(lastName) == null &&
        FormValidators.email(email) == null &&
        FormValidators.password(password) == null &&
        FormValidators.confirmPassword(confirmPassword, password) == null;
  }

  static String? _personName(String? value, String label) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return '$label is required';
    }
    if (text.length < 2) {
      return '$label must be at least 2 characters';
    }
    if (!_namePattern.hasMatch(text)) {
      return '$label can only contain letters, spaces, hyphens, or apostrophes';
    }
    return null;
  }
}
