import 'package:brandface/domain/entities/profile/portfolio_entity.dart';

abstract class AmbassadorPortfolioState {}

class AmbassadorPortfolioInitial extends AmbassadorPortfolioState {}

class AmbassadorPortfolioLoading extends AmbassadorPortfolioState {}

class AmbassadorPortfolioLoaded extends AmbassadorPortfolioState {
  final List<PortfolioItemEntity> items;
  AmbassadorPortfolioLoaded(this.items);
}

class AmbassadorPortfolioFailure extends AmbassadorPortfolioState {
  final String message;
  AmbassadorPortfolioFailure(this.message);
}
