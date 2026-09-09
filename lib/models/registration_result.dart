/// Snapshot of a successful registration.
/// Password is intentionally omitted so it is never shown after submit.
class RegistrationResult {
  const RegistrationResult({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String firstName;
  final String lastName;
  final String email;

  String get fullName => '$firstName $lastName';
}
