import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/home/get_home_dashboard_use_case.dart';
import 'package:brandface/presentation/home_page/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDashboardUseCase _getHomeDashboardUseCase;

  HomeCubit({required GetHomeDashboardUseCase getHomeDashboardUseCase})
    : _getHomeDashboardUseCase = getHomeDashboardUseCase,
      super(const HomeState());

  Future<void> loadHome() async {
    emit(state.copyWith(status: HomeStatus.loading, clearFailure: true));

    final result = await _getHomeDashboardUseCase.call(params: null);

    result.fold(
      ifLeft: (failure) =>
          emit(state.copyWith(status: HomeStatus.failure, failure: failure)),
      ifRight: (dashboard) => emit(
        state.copyWith(
          status: HomeStatus.success,
          dashboard: dashboard,
          clearFailure: true,
        ),
      ),
    );
  }
}
