part of 'send_enquiry_cubit.dart';

@freezed
class SendEnquiryState with _$SendEnquiryState {
  const factory SendEnquiryState.initial() = _Initial;
  const factory SendEnquiryState.sending() = _Sending;
  const factory SendEnquiryState.sent() = _Sent;
  const factory SendEnquiryState.failure({required Failure failure}) = _Failure;
}
