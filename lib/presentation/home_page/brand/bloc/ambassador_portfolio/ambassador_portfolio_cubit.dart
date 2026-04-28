import 'package:bloc/bloc.dart';
import 'package:brandface/domain/repository/portfolio_repository.dart';
import 'ambassador_portfolio_state.dart';

class AmbassadorPortfolioCubit extends Cubit<AmbassadorPortfolioState> {
  final IPortfolioRepository _repository;

  AmbassadorPortfolioCubit({required IPortfolioRepository portfolioRepository})
      : _repository = portfolioRepository,
        super(AmbassadorPortfolioInitial());

  Future<void> load(int influencerId) async {
    emit(AmbassadorPortfolioLoading());
    final result =
        await _repository.getPublicPortfolio(influencerId: influencerId);
    result.fold(
      ifLeft: (f) => emit(AmbassadorPortfolioFailure(f.message)),
      ifRight: (items) => emit(AmbassadorPortfolioLoaded(items)),
    );
  }
}
