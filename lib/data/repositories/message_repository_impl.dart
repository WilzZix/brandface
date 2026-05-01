import 'package:brandface/core/error/failures.dart';
import 'package:brandface/data/data_source/network_data_source/message/message_data_source.dart';
import 'package:brandface/domain/entities/message/conversation_entity.dart';
import 'package:brandface/domain/repository/message_repository.dart';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';

class MessageRepositoryImpl implements IMessageRepository {
  MessageRepositoryImpl({required MessageDataSource dataSource})
    : _dataSource = dataSource;

  final MessageDataSource _dataSource;

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    try {
      final conversations = await _dataSource.getConversations();
      return Right(conversations);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> sendEnquiry({
    required int otherUserId,
    required String text,
  }) async {
    try {
      final conversationId = await _dataSource.startConversation(
        otherUserId: otherUserId,
      );
      await _dataSource.sendMessage(
        conversationId: conversationId,
        text: text,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioFailure(e));
    } catch (e) {
      return Left(ServerFailure('Tizim xatoligi: ${e.toString()}'));
    }
  }

  ServerFailure _mapDioFailure(DioException e) {
    final responseData = e.response?.data;
    String message = e.message ?? 'Serverda xatolik yuz berdi';

    if (responseData is Map && responseData['message'] != null) {
      message = responseData['message'].toString();
    } else if (responseData is Map && responseData['detail'] != null) {
      message = responseData['detail'].toString();
    }

    return ServerFailure(
      message,
      statusCode: e.response?.statusCode,
      errorData: responseData,
    );
  }
}
