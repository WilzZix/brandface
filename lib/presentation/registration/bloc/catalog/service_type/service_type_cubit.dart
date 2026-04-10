import 'package:bloc/bloc.dart';
import 'package:brandface/domain/entities/profile/catalog/service_type_entity.dart';
import 'package:brandface/domain/usecase/catalog/category/service_type_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/error/failures.dart';

part 'service_type_state.dart';

part 'service_type_cubit.freezed.dart';

class ServiceTypeCubit extends Cubit<ServiceTypeState> {
  ServiceTypeCubit({required ServiceTypeUseCase serviceTypeUseCase})
    : _serviceTypeUseCase = serviceTypeUseCase,
      super(const ServiceTypeState.initial());

  final ServiceTypeUseCase _serviceTypeUseCase;

  Future<void> getServiceType() async {
    emit((ServiceTypeState.loading()));
    final result = await _serviceTypeUseCase.call(params: null);
    result.fold(
      ifLeft: (failure) =>
          emit(ServiceTypeState.serviceTypeLoadedLoadFailure(failure: failure)),
      ifRight: (data) => emit(ServiceTypeState.serviceTypeLoaded(data: data)),
    );
  }
}
