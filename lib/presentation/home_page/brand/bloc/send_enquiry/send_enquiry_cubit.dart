import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/usecase/message/send_enquiry_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_enquiry_state.dart';
part 'send_enquiry_cubit.freezed.dart';

class SendEnquiryCubit extends Cubit<SendEnquiryState> {
  SendEnquiryCubit({required SendEnquiryUseCase useCase})
    : _useCase = useCase,
      super(const SendEnquiryState.initial());

  final SendEnquiryUseCase _useCase;

  Future<void> submit({
    required int otherUserId,
    required String contactName,
    required String companyName,
    required String contactNumber,
    required String message,
  }) async {
    emit(const SendEnquiryState.sending());
    final result = await _useCase.call(
      params: SendEnquiryParams(
        otherUserId: otherUserId,
        contactName: contactName,
        companyName: companyName,
        contactNumber: contactNumber,
        message: message,
      ),
    );
    result.fold(
      ifLeft: (failure) => emit(SendEnquiryState.failure(failure: failure)),
      ifRight: (_) => emit(const SendEnquiryState.sent()),
    );
  }
}
