import 'package:brandface/core/error/exception_mapper.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/message/message_data_source.dart';
import 'package:brandface/domain/entities/message/conversation_entity.dart';
import 'package:brandface/domain/repository/message_repository.dart';
import 'package:dart_either/dart_either.dart';

final class MessageRepositoryImpl implements IMessageRepository {
  MessageRepositoryImpl({required MessageDataSource dataSource})
    : _dataSource = dataSource;

  final MessageDataSource _dataSource;

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() {
    return guard(() => _dataSource.getConversations());
  }

  @override
  Future<Either<Failure, void>> sendEnquiry({
    required int otherUserId,
    required String text,
  }) {
    return guard(() async {
      final conversationId = await _dataSource.startConversation(
        otherUserId: otherUserId,
      );
      await _dataSource.sendMessage(
        conversationId: conversationId,
        text: text,
      );
    });
  }
}
