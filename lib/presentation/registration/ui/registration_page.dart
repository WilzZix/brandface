import 'package:brandface/domain/usecase/registration/params/registration_params.dart';
import 'package:brandface/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../uikit/components/inputs/cred_input_field.dart';
import 'components/select_role.dart';
import 'fill_profile_information_page.dart';

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
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          state.maybeWhen(
            userRegistered: (registerEntity) {
              context.push(FillProfileInformationPage.tag);
            },
            userRegisterFailure: (msg) {},
            orElse: () {},
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(t.registration.title, style: Typographies.headlineSmall),
              SizedBox(height: 24),
              SelectRole(
                onRoleSelected: (role) {
                  selectedRole = role;
                },
              ),
              SizedBox(height: 24),
              CredInputField(controller: _nameController, label: t.registration.your_name),
              SizedBox(height: 16),
              CredInputField(controller: _surnameController, label: t.registration.your_surname),
              Spacer(),
              AppButtons.primary(
                title: t.onboarding.kContinue,
                onTap: () {
                  context.read<RegistrationBloc>().add(
                    RegistrationEvent.registration(
                      params: RegistrationParams(
                        role: selectedRole ?? '',
                        firstName: _nameController.text,
                        lastName: _surnameController.text,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
