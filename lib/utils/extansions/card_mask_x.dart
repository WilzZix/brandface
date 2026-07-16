import 'package:brandface/domain/entities/billing/billing_entities.dart';

/// Display helpers for saved billing cards.
extension BillingCardDisplayX on BillingCardEntity {
  /// The masked PAN grouped into 4-character blocks for readability, e.g.
  /// `860034******3265` → `8600 34** **** 3265`.
  ///
  /// Falls back to the raw [name] when it doesn't look like a card mask
  /// (so nicknames or unexpected shapes are shown untouched).
  String get maskedNumber {
    final compact = name.trim().replaceAll(' ', '');
    final isCardMask =
        compact.length >= 12 && RegExp(r'^[0-9*•xX]+$').hasMatch(compact);
    if (!isCardMask) return name.trim();

    final buffer = StringBuffer();
    for (var i = 0; i < compact.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(compact[i]);
    }
    return buffer.toString();
  }
}
