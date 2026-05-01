import 'package:brandface/core/constants/api_routes.dart';
import 'package:brandface/core/network/dio_client.dart';
import 'package:brandface/data/models/message/conversation_model.dart';

abstract class MessageDataSource {
  Future<List<ConversationModel>> getConversations();

  Future<int> startConversation({required int otherUserId});

  Future<void> sendMessage({
    required int conversationId,
    required String text,
  });
}

class MessageDataSourceImpl implements MessageDataSource {
  MessageDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<List<ConversationModel>> getConversations() async {
    final response = await _dioClient.get(ApiRoutes.conversations);
    final list = _extractList(response.data);

    return list
        .map((item) => ConversationModel.fromJson(_readMap(item)))
        .toList();
  }

  @override
  Future<int> startConversation({required int otherUserId}) async {
    final response = await _dioClient.post(
      ApiRoutes.conversations,
      data: {'other_user_id': otherUserId},
    );
    final map = _readMap(response.data);
    final id = (map['id'] ?? map['conversation_id']) as int?;
    if (id == null) {
      throw StateError('Conversation id missing in response');
    }
    return id;
  }

  @override
  Future<void> sendMessage({
    required int conversationId,
    required String text,
  }) async {
    await _dioClient.post(
      ApiRoutes.sendMessage(conversationId),
      data: {'text': text},
    );
  }

  List<dynamic> _extractList(dynamic payload) {
    if (payload is List) {
      return payload;
    }

    final root = _readMap(payload);
    final data = root['data'];

    if (data is List) {
      return data;
    }

    if (data is Map) {
      if (data['results'] is List) {
        return data['results'] as List<dynamic>;
      }

      if (data['items'] is List) {
        return data['items'] as List<dynamic>;
      }
    }

    if (root['results'] is List) {
      return root['results'] as List<dynamic>;
    }

    if (root['items'] is List) {
      return root['items'] as List<dynamic>;
    }

    return const [];
  }

  Map<String, dynamic> _readMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return <String, dynamic>{};
  }
}
