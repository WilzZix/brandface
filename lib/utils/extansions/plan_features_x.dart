import 'package:brandface/domain/entities/billing/billing_entities.dart';

/// Parses a plan's raw [BillingPlanEntity.features] blob into clean feature
/// lines for display.
extension BillingPlanFeaturesX on BillingPlanEntity {
  /// The backend sends features as a stringified list, e.g.
  /// `["Oyiga 1 ta offer", "Asosiy analitika"]` or
  /// `[Oyiga 1 ta offer, Asosiy analitika]`. Without cleaning, the UI shows the
  /// wrapping `[` … `]` and per-item quotes as literal text. This strips them
  /// and returns clean lines (empty list when there's nothing usable).
  List<String> get featureList {
    var raw = (features ?? '').trim();
    if (raw.isEmpty) return const [];

    // Drop a single pair of wrapping brackets/braces.
    final first = raw[0];
    final last = raw[raw.length - 1];
    if ((first == '[' && last == ']') || (first == '{' && last == '}')) {
      raw = raw.substring(1, raw.length - 1);
    }

    return raw
        .replaceAll('\n', ',')
        .replaceAll(';', ',')
        .replaceAll('|', ',')
        .split(',')
        .map(_cleanFeatureItem)
        .where((item) => item.isNotEmpty)
        .toList();
  }
}

/// Trims a single feature and strips any leftover brackets/braces and a
/// wrapping pair of quotes.
String _cleanFeatureItem(String item) {
  var s = item.trim().replaceAll(RegExp(r'^[\[\]{}]+|[\[\]{}]+$'), '').trim();
  if (s.length >= 2) {
    final first = s[0];
    final last = s[s.length - 1];
    if ((first == '"' && last == '"') || (first == "'" && last == "'")) {
      s = s.substring(1, s.length - 1).trim();
    }
  }
  return s;
}
