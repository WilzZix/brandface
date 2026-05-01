import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/repository/message_repository.dart';
import 'package:dart_either/dart_either.dart';

class SendEnquiryParams {
  final int otherUserId;
  final String contactName;
  final String companyName;
  final String contactNumber;
  final String message;

  const SendEnquiryParams({
    required this.otherUserId,
    required this.contactName,
    required this.companyName,
    required this.contactNumber,
    required this.message,
  });

  String buildMessageText() {
    final lines = <String>[
      'Contact name: $contactName',
      'Company name: $companyName',
      'Contact number: $contactNumber',
      '',
      message,
    ];
    return lines.join('\n');
  }
}

class SendEnquiryUseCase {
  final IMessageRepository repository;

  SendEnquiryUseCase(this.repository);

  Future<Either<Failure, void>> call({required SendEnquiryParams params}) {
    return repository.sendEnquiry(
      otherUserId: params.otherUserId,
      text: params.buildMessageText(),
    );
  }
}
