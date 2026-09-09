import 'package:flutter/material.dart';

import '../models/registration_result.dart';
import '../theme/app_theme.dart';
import '../validation/form_validators.dart';
import '../widgets/petal_text_field.dart';
import '../widgets/result_card.dart';

/// Registration form screen.
///
/// This is a [StatefulWidget] because the screen owns [TextEditingController]s,
/// [FocusNode]s, password-visibility flags, and the last successful result.
/// Those values change while the app is running, so they belong in [State].
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  RegistrationResult? _result;

  @override
  void initState() {
    super.initState();
    // Rebuild whenever text changes so the Submit button can enable/disable live.
    for (final controller in _controllers) {
      controller.addListener(_onFieldsChanged);
    }
  }

  List<TextEditingController> get _controllers => [
        _firstNameController,
        _lastNameController,
        _emailController,
        _passwordController,
        _confirmPasswordController,
      ];

  void _onFieldsChanged() {
    setState(() {});
  }

  bool get _canSubmit => FormValidators.isFormValid(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller
        ..removeListener(_onFieldsChanged)
        ..dispose();
    }
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  void _unfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  Future<void> _submit() async {
    _unfocusKeyboard();

    // FormState.validate() runs every TextFormField.validator.
    // Success UI is shown only when every field passes.
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final result = RegistrationResult(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
    );

    await _showSuccessDialog(result);

    if (!mounted) {
      return;
    }

    setState(() {
      _result = result;
      for (final controller in _controllers) {
        controller.clear();
      }
      _formKey.currentState?.reset();
      _hidePassword = true;
      _hideConfirmPassword = true;
    });
  }

  Future<void> _showSuccessDialog(RegistrationResult result) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: PetalColors.cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          title: const Text('You are in, pretty flower'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('First name: ${result.firstName}'),
              const SizedBox(height: 6),
              Text('Last name: ${result.lastName}'),
              const SizedBox(height: 6),
              Text('Email: ${result.email}'),
              const SizedBox(height: 6),
              const Text('Password: saved (hidden)'),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                backgroundColor: PetalColors.leaf,
                foregroundColor: Colors.white,
              ),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tapping empty space unfocuses the active field and closes the keyboard.
    return GestureDetector(
      onTap: _unfocusKeyboard,
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        // Lets the body shrink when the keyboard opens instead of overflowing.
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            const _GardenBackdrop(),
            SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                child: Column(
                  children: [
                    const _Header(),
                    if (_result != null) ...[
                      const SizedBox(height: 16),
                      ResultCard(result: _result!),
                    ],
                    const SizedBox(height: 18),
                    _FormCard(
                      formKey: _formKey,
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      firstNameFocus: _firstNameFocus,
                      lastNameFocus: _lastNameFocus,
                      emailFocus: _emailFocus,
                      passwordFocus: _passwordFocus,
                      confirmPasswordFocus: _confirmPasswordFocus,
                      hidePassword: _hidePassword,
                      hideConfirmPassword: _hideConfirmPassword,
                      canSubmit: _canSubmit,
                      onTogglePassword: () {
                        setState(() => _hidePassword = !_hidePassword);
                      },
                      onToggleConfirmPassword: () {
                        setState(
                          () => _hideConfirmPassword = !_hideConfirmPassword,
                        );
                      },
                      onSubmit: _submit,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [PetalColors.petal, PetalColors.sage],
            ),
            boxShadow: [
              BoxShadow(
                color: PetalColors.rose.withValues(alpha: 0.28),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(
            Icons.local_florist_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          'Create your account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: PetalColors.ink,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A little pink, a little green, all yours.',
          style: TextStyle(
            color: PetalColors.ink.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard({
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.firstNameFocus,
    required this.lastNameFocus,
    required this.emailFocus,
    required this.passwordFocus,
    required this.confirmPasswordFocus,
    required this.hidePassword,
    required this.hideConfirmPassword,
    required this.canSubmit,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode firstNameFocus;
  final FocusNode lastNameFocus;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final FocusNode confirmPasswordFocus;
  final bool hidePassword;
  final bool hideConfirmPassword;
  final bool canSubmit;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 18),
      decoration: BoxDecoration(
        color: PetalColors.cream.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: PetalColors.rose.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: AutofillGroup(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PetalTextField(
                controller: firstNameController,
                focusNode: firstNameFocus,
                label: 'First name',
                icon: Icons.person_outline_rounded,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.givenName],
                validator: FormValidators.firstName,
                onFieldSubmitted: (_) => lastNameFocus.requestFocus(),
              ),
              const SizedBox(height: 14),
              PetalTextField(
                controller: lastNameController,
                focusNode: lastNameFocus,
                label: 'Last name',
                icon: Icons.badge_outlined,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.familyName],
                validator: FormValidators.lastName,
                onFieldSubmitted: (_) => emailFocus.requestFocus(),
              ),
              const SizedBox(height: 14),
              PetalTextField(
                controller: emailController,
                focusNode: emailFocus,
                label: 'Email',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: FormValidators.email,
                onFieldSubmitted: (_) => passwordFocus.requestFocus(),
              ),
              const SizedBox(height: 14),
              PetalTextField(
                controller: passwordController,
                focusNode: passwordFocus,
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                obscureText: hidePassword,
                autofillHints: const [AutofillHints.newPassword],
                validator: FormValidators.password,
                onToggleObscure: onTogglePassword,
                onFieldSubmitted: (_) => confirmPasswordFocus.requestFocus(),
              ),
              const SizedBox(height: 14),
              PetalTextField(
                controller: confirmPasswordController,
                focusNode: confirmPasswordFocus,
                label: 'Confirm password',
                icon: Icons.lock_person_outlined,
                obscureText: hideConfirmPassword,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
                validator: (value) => FormValidators.confirmPassword(
                  value,
                  passwordController.text,
                ),
                onToggleObscure: onToggleConfirmPassword,
                onFieldSubmitted: (_) {
                  if (canSubmit) {
                    onSubmit();
                  }
                },
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 54,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: canSubmit
                        ? const LinearGradient(
                            colors: [PetalColors.rose, PetalColors.leaf],
                          )
                        : LinearGradient(
                            colors: [
                              PetalColors.petal.withValues(alpha: 0.45),
                              PetalColors.sage.withValues(alpha: 0.45),
                            ],
                          ),
                    boxShadow: canSubmit
                        ? [
                            BoxShadow(
                              color: PetalColors.rose.withValues(alpha: 0.28),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : null,
                  ),
                  child: FilledButton(
                    onPressed: canSubmit ? onSubmit : null,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white70,
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                canSubmit
                    ? 'Looks good — tap Register when you are ready.'
                    : 'Fill every field correctly to enable Register.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: PetalColors.ink.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Soft decorative blobs so the screen feels garden-like without extra assets.
class _GardenBackdrop extends StatelessWidget {
  const _GardenBackdrop();

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -40,
            child: _Blob(color: PetalColors.petal, size: 220),
          ),
          Positioned(
            top: 120,
            left: -70,
            child: _Blob(color: PetalColors.sage, size: 180),
          ),
          Positioned(
            bottom: 80,
            right: -50,
            child: _Blob(color: PetalColors.mist, size: 200),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.38),
      ),
    );
  }
}
