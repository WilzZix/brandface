import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/usecase/login/delete_account_use_case.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final DeleteAccountUseCase _deleteAccountUseCase;

  DeleteAccountCubit({required DeleteAccountUseCase deleteAccountUseCase})
      : _deleteAccountUseCase = deleteAccountUseCase,
        super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());
    final result = await _deleteAccountUseCase.call();
    result.fold(
      ifLeft: (failure) => emit(DeleteAccountFailure(failure)),
      ifRight: (_) => emit(DeleteAccountSuccess()),
    );
  }
}
