import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/profile/get_my_portfolios_use_case.dart';
import 'package:brandface/presentation/home_page/profile/bloc/portfolio/portfolio_list_state.dart';

class PortfolioListCubit extends Cubit<PortfolioListState> {
  final GetMyPortfoliosUseCase _getMyPortfoliosUseCase;

  PortfolioListCubit({required GetMyPortfoliosUseCase getMyPortfoliosUseCase})
    : _getMyPortfoliosUseCase = getMyPortfoliosUseCase,
      super(const PortfolioListState());

  Future<void> loadPortfolios({bool force = false}) async {
    if (!force && state.status == PortfolioListStatus.loading) {
      return;
    }

    emit(
      state.copyWith(status: PortfolioListStatus.loading, clearFailure: true),
    );

    final result = await _getMyPortfoliosUseCase.call(params: null);
    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(status: PortfolioListStatus.failure, failure: failure),
      ),
      ifRight: (items) => emit(
        state.copyWith(
          status: PortfolioListStatus.success,
          items: items,
          clearFailure: true,
        ),
      ),
    );
  }
}
