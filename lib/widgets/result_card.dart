import 'package:flutter/material.dart';

import '../models/registration_result.dart';
import '../theme/app_theme.dart';

/// On-screen copy of the submitted registration details.
/// Password is never included here.
class ResultCard extends StatelessWidget {
  const ResultCard({super.key, required this.result});

  final RegistrationResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: PetalColors.mist,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: PetalColors.sage.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: PetalColors.leaf),
              SizedBox(width: 8),
              Text(
                'Registration successful',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: PetalColors.leaf,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _line('First name', result.firstName),
          _line('Last name', result.lastName),
          _line('Email', result.email),
          _line('Password', 'saved (hidden)'),
        ],
      ),
    );
  }

  Widget _line(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                color: PetalColors.ink,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: PetalColors.ink),
            ),
          ],
        ),
      ),
    );
  }
}
