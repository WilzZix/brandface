import 'package:equatable/equatable.dart';

base class ConversationParticipantEntity extends Equatable {
  const ConversationParticipantEntity({
    required this.id,
    required this.phoneNumber,
    required this.role,
  });

  final int id;
  final String phoneNumber;
  final String role;

  @override
  List<Object?> get props => [id, phoneNumber, role];
}

base class ConversationEntity extends Equatable {
  const ConversationEntity({
    required this.id,
    required this.participants,
    this.offerId,
    this.lastMessageAt,
    this.lastMessage,
    this.createdAt,
  });

  final int id;
  final List<ConversationParticipantEntity> participants;
  final int? offerId;
  final DateTime? lastMessageAt;
  final String? lastMessage;
  final DateTime? createdAt;

  ConversationParticipantEntity? get counterpart {
    for (final participant in participants) {
      if (participant.role.trim().toLowerCase() != 'influencer') {
        return participant;
      }
    }

    return participants.isEmpty ? null : participants.first;
  }

  @override
  List<Object?> get props => [
    id,
    participants,
    offerId,
    lastMessageAt,
    lastMessage,
    createdAt,
  ];
}
