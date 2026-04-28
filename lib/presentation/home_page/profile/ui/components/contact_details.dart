import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/domain/entities/profile/profile_entity.dart';
import 'package:brandface/utils/extansions/app_exts.dart';
import 'package:flutter/material.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails({super.key, required this.contactData});

  final List<ContactEntity>? contactData;

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    if (widget.contactData == null || widget.contactData!.isEmpty) {
      return Text(
        t.common.no_contact_details,
        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Text('${widget.contactData?[index].type}: '),
            Text('${widget.contactData?[index].value!.toPrettyPhoneFormat()}'),
          ],
        );
      },
      itemCount: widget.contactData?.length ?? 1,
    );
  }
}
