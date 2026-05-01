import 'package:brandface/core/di/app_di.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/presentation/home_page/brand/bloc/send_enquiry/send_enquiry_cubit.dart';
import 'package:brandface/uikit/components/bottom_sheet/brandface_bottom_sheet.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/components/inputs/cred_input_field.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SendEnquiryArguments {
  final int otherUserId;

  const SendEnquiryArguments({required this.otherUserId});
}

class SendEnquiryPage extends StatelessWidget {
  const SendEnquiryPage({super.key, required this.arguments});

  static const String tag = '/send-enquiry';

  final SendEnquiryArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendEnquiryCubit>(
      create: (_) => sl<SendEnquiryCubit>(),
      child: _SendEnquiryView(otherUserId: arguments.otherUserId),
    );
  }
}

class _SendEnquiryView extends StatefulWidget {
  const _SendEnquiryView({required this.otherUserId});

  final int otherUserId;

  @override
  State<_SendEnquiryView> createState() => _SendEnquiryViewState();
}

class _SendEnquiryViewState extends State<_SendEnquiryView> {
  final _formKey = GlobalKey<FormState>();
  final _contactNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _contactNameController.dispose();
    _companyNameController.dispose();
    _contactNumberController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<SendEnquiryCubit>().submit(
      otherUserId: widget.otherUserId,
      contactName: _contactNameController.text.trim(),
      companyName: _companyNameController.text.trim(),
      contactNumber: _contactNumberController.text.trim(),
      message: _messageController.text.trim(),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send enquiry'), centerTitle: false),
      body: BlocListener<SendEnquiryCubit, SendEnquiryState>(
        listener: (context, state) {
          state.maybeWhen(
            sent: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Enquiry sent')),
              );
              context.pop();
            },
            failure: (Failure failure) {
              BrandfaceBottomSheet.openFailureBottomSheet(
                context: context,
                message: failure.localized,
              );
            },
            orElse: () {},
          );
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Contact name'),
                      CredInputField(
                        controller: _contactNameController,
                        label: 'Write Contact name',
                        validator: _required,
                      ),
                      const SizedBox(height: 16),
                      _label('Company name'),
                      CredInputField(
                        controller: _companyNameController,
                        label: 'Write Company name',
                        validator: _required,
                      ),
                      const SizedBox(height: 16),
                      _label('Contact number'),
                      CredInputField(
                        controller: _contactNumberController,
                        label: 'Write Contact number',
                        validator: _required,
                      ),
                      const SizedBox(height: 16),
                      _label('Message'),
                      TextFormField(
                        controller: _messageController,
                        maxLines: 5,
                        validator: _required,
                        decoration: InputDecoration(
                          hintText: 'Write message here',
                          hintStyle: Typographies.bodyMedium.copyWith(
                            color: AppColors.grey,
                          ),
                          filled: true,
                          fillColor: AppColors.lightBg2,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.borderColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: AppColors.borderColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _Footer(onSubmit: _submit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(text, style: Typographies.titleSmall),
  );
}

class _Footer extends StatelessWidget {
  const _Footer({required this.onSubmit});
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendEnquiryCubit, SendEnquiryState>(
      builder: (context, state) {
        final isSending = state.maybeWhen(
          sending: () => true,
          orElse: () => false,
        );
        return Container(
          padding: EdgeInsets.fromLTRB(
            16,
            12,
            16,
            MediaQuery.of(context).padding.bottom + 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.lightBg,
            border: Border(top: BorderSide(color: AppColors.borderColor)),
          ),
          child: Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: isSending ? null : () => context.pop(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Text('Cancel', style: Typographies.titleMedium),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 180,
                child: AppButtons.primary(
                  title: isSending ? 'Sending...' : 'Submit',
                  onTap: isSending ? null : onSubmit,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
