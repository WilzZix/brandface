import 'package:brandface/domain/usecase/registration/params/registration_params.dart';
import 'package:brandface/presentation/registration/bloc/registration/registration_bloc.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/enums/enums.dart';
import '../../../core/error/failures.dart';
import '../../../core/i18n/strings.g.dart';
import '../../../uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
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
  UserRole _selectedUserRole = UserRole.influencer;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _brandNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          state.maybeWhen(
            userRegistered: (registerEntity) {
              context.push(
                FillProfileInformationPage.tag,
                extra: registerEntity,
              );
            },
            userRegisterFailure: (msg) {
              BrandfaceBottomSheet.openFailureBottomSheet(
                context: context,
                message: msg.localized,
              );
            },
            orElse: () {},
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(t.registration.title, style: Typographies.headlineSmall),
                SizedBox(height: 24),
                SelectRole(
                  onRoleSelected: (role) {
                    setState(() {
                      _selectedUserRole = _roleFromString(role);
                    });
                  },
                ),
                SizedBox(height: 24),
                if (_selectedUserRole == UserRole.brand) ...[
                  CredInputField(
                    controller: _brandNameController,
                    label: t.registration.brand_name,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ] else ...[
                  CredInputField(
                    controller: _nameController,
                    label: t.registration.your_name,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  CredInputField(
                    controller: _surnameController,
                    label: t.registration.your_surname,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ],
                Spacer(),
                AppButtons.primary(
                  title: t.onboarding.kContinue,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<RegistrationBloc>().add(
                        RegistrationEvent.registration(
                          params: _selectedUserRole == UserRole.brand
                              ? RegistrationParams(
                                  role: _selectedUserRole.name,
                                  brandName: _brandNameController.text,
                                )
                              : RegistrationParams(
                                  role: _selectedUserRole.name,
                                  firstName: _nameController.text,
                                  lastName: _surnameController.text,
                                ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 16 + MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }

  UserRole _roleFromString(String role) {
    switch (role.toLowerCase()) {
      case 'ambassador':
        return UserRole.ambassador;
      case 'brandface':
        return UserRole.brandface;
      case 'brand':
        return UserRole.brand;
      default:
        return UserRole.influencer;
    }
  }
}
