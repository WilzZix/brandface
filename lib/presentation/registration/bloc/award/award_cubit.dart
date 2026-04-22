import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/award_entity.dart';
import 'package:brandface/domain/usecase/profile/create_award_use_case.dart';
import 'package:brandface/domain/usecase/profile/delete_award_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'award_state.dart';
part 'award_cubit.freezed.dart';

class AwardCubit extends Cubit<AwardState> {
  final CreateAwardUseCase _createAwardUseCase;
  final DeleteAwardUseCase _deleteAwardUseCase;

  AwardCubit({
    required CreateAwardUseCase createAwardUseCase,
    required DeleteAwardUseCase deleteAwardUseCase,
  })  : _createAwardUseCase = createAwardUseCase,
        _deleteAwardUseCase = deleteAwardUseCase,
        super(const AwardState.initial());

  Future<void> createAward({required String title}) async {
    final currentAwards = state.awards;
    emit(AwardState.loading(awards: currentAwards));
    final result = await _createAwardUseCase.call(params: title);
    result.fold(
      ifLeft: (failure) =>
          emit(AwardState.failure(awards: currentAwards, failure: failure)),
      ifRight: (award) =>
          emit(AwardState.success(awards: [...currentAwards, award])),
    );
  }

  Future<void> deleteAward({required int awardId}) async {
    final currentAwards = state.awards;
    emit(AwardState.loading(awards: currentAwards));
    final result = await _deleteAwardUseCase.call(params: awardId);
    result.fold(
      ifLeft: (failure) =>
          emit(AwardState.failure(awards: currentAwards, failure: failure)),
      ifRight: (_) => emit(AwardState.success(
        awards: currentAwards.where((a) => a.id != awardId).toList(),
      )),
    );
  }
}

extension on AwardState {
  List<AwardEntity> get awards => maybeWhen(
        initial: (awards) => awards,
        loading: (awards) => awards,
        success: (awards) => awards,
        failure: (awards, _) => awards,
        orElse: () => [],
      );
}
