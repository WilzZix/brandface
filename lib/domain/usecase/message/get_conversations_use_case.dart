import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/message/conversation_entity.dart';
import 'package:brandface/domain/repository/message_repository.dart';
import 'package:brandface/domain/usecase/login/send_otp_usecase.dart';
import 'package:dart_either/dart_either.dart';

final class GetConversationsUseCase
    implements UseCase<List<ConversationEntity>, void> {
  GetConversationsUseCase({required this.repository});

  final IMessageRepository repository;

  @override
  Future<Either<Failure, List<ConversationEntity>>> call({
    required void params,
  }) {
    return repository.getConversations();
  }
}
