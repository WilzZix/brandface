import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/message/conversation_entity.dart';
import 'package:dart_either/dart_either.dart';

abstract class IMessageRepository {
  Future<Either<Failure, List<ConversationEntity>>> getConversations();

  Future<Either<Failure, void>> sendEnquiry({
    required int otherUserId,
    required String text,
  });
}
