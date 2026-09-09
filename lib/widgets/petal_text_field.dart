import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Shared outlined field so every input looks the same and
/// keyboard actions (next / done) stay consistent.
class PetalTextField extends StatelessWidget {
  const PetalTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.icon,
    required this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.onFieldSubmitted,
    this.onToggleObscure,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final IconData icon;
  final String? Function(String?) validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onToggleObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      autofillHints: autofillHints,
      autocorrect: keyboardType != TextInputType.emailAddress,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: PetalColors.leaf),
        suffixIcon: onToggleObscure == null
            ? null
            : IconButton(
                tooltip: obscureText ? 'Show password' : 'Hide password',
                onPressed: onToggleObscure,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
              ),
      ),
    );
  }
}
