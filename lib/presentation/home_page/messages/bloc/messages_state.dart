import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/message/conversation_entity.dart';
import 'package:equatable/equatable.dart';

enum MessagesStatus { initial, loading, success, failure }

class MessagesState extends Equatable {
  const MessagesState({
    this.status = MessagesStatus.initial,
    this.conversations = const [],
    this.hiddenConversationIds = const {},
    this.failure,
  });

  final MessagesStatus status;
  final List<ConversationEntity> conversations;
  final Set<int> hiddenConversationIds;
  final Failure? failure;

  List<ConversationEntity> get visibleConversations => conversations
      .where((item) => !hiddenConversationIds.contains(item.id))
      .toList(growable: false);

  MessagesState copyWith({
    MessagesStatus? status,
    List<ConversationEntity>? conversations,
    Set<int>? hiddenConversationIds,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return MessagesState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
      hiddenConversationIds:
          hiddenConversationIds ?? this.hiddenConversationIds,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
    status,
    conversations,
    hiddenConversationIds,
    failure,
  ];
}
