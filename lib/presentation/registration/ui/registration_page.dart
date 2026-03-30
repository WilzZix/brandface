import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../uikit/components/inputs/cred_input_field.dart';
import 'components/select_role.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static const String tag = '/registration';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? selectedRole;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text('Registration', style: Typographies.headlineSmall),
            SizedBox(height: 24),
            SelectRole(
              onRoleSelected: (role) {
                selectedRole = role;
              },
            ),
            SizedBox(height: 24),
            CredInputField(controller: _nameController, label: 'Your name'),
            SizedBox(height: 16),
            CredInputField(controller: _surnameController, label: 'Your surname'),
            Spacer(),
            AppButtons.primary(title: t.onboarding.kContinue, onTap: () {}),
            SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
