import 'package:brandface/domain/entities/profile/ambassador_entity.dart';
import 'package:equatable/equatable.dart';

/// One horizontal/vertical people block on the brand home page. Each slot
/// loads on its own so a single failing request never blanks the others.
class PeopleSlot extends Equatable {
  final bool isLoading;
  final List<AmbassadorEntity> items;
  final String? error;

  const PeopleSlot({
    this.isLoading = false,
    this.items = const [],
    this.error,
  });

  const PeopleSlot.loading() : this(isLoading: true);

  /// A slot with nothing to show — either still empty, failed, or genuinely
  /// returned no people. Callers hide the whole section in that case.
  bool get isEmpty => !isLoading && items.isEmpty;

  @override
  List<Object?> get props => [isLoading, items, error];
}

class BrandPeopleListsState extends Equatable {
  final PeopleSlot vip;
  final PeopleSlot top;
  final PeopleSlot influencers;
  final PeopleSlot ambassadors;

  const BrandPeopleListsState({
    this.vip = const PeopleSlot(),
    this.top = const PeopleSlot(),
    this.influencers = const PeopleSlot(),
    this.ambassadors = const PeopleSlot(),
  });

  BrandPeopleListsState copyWith({
    PeopleSlot? vip,
    PeopleSlot? top,
    PeopleSlot? influencers,
    PeopleSlot? ambassadors,
  }) {
    return BrandPeopleListsState(
      vip: vip ?? this.vip,
      top: top ?? this.top,
      influencers: influencers ?? this.influencers,
      ambassadors: ambassadors ?? this.ambassadors,
    );
  }

  @override
  List<Object?> get props => [vip, top, influencers, ambassadors];
}
