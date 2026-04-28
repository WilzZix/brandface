import 'package:brandface/domain/entities/message/conversation_entity.dart';

class ConversationParticipantModel extends ConversationParticipantEntity {
  const ConversationParticipantModel({
    required super.id,
    required super.phoneNumber,
    required super.role,
  });

  factory ConversationParticipantModel.fromJson(Map<String, dynamic> json) {
    return ConversationParticipantModel(
      id: _toInt(json['id']),
      phoneNumber: json['phone_number']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
    );
  }
}

class ConversationModel extends ConversationEntity {
  const ConversationModel({
    required super.id,
    required super.participants,
    super.offerId,
    super.lastMessageAt,
    super.lastMessage,
    super.createdAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    final participantsJson = json['participants'];

    return ConversationModel(
      id: _toInt(json['id']),
      participants: participantsJson is List
          ? participantsJson
                .map(
                  (item) =>
                      ConversationParticipantModel.fromJson(_readMap(item)),
                )
                .toList()
          : const [],
      offerId: json['offer'] == null ? null : _toInt(json['offer']),
      lastMessageAt: _toDateTime(json['last_message_at']),
      lastMessage: json['last_message']?.toString(),
      createdAt: _toDateTime(json['created_at']),
    );
  }
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

int _toInt(dynamic value) {
  if (value is int) {
    return value;
  }

  return int.tryParse(value?.toString() ?? '') ?? 0;
}

DateTime? _toDateTime(dynamic value) {
  if (value == null) {
    return null;
  }

  return DateTime.tryParse(value.toString());
}
