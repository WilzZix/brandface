import 'package:bloc/bloc.dart';
import 'package:brandface/domain/usecase/message/get_conversations_use_case.dart';
import 'package:brandface/presentation/home_page/messages/bloc/messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit({required GetConversationsUseCase getConversationsUseCase})
    : _getConversationsUseCase = getConversationsUseCase,
      super(const MessagesState());

  final GetConversationsUseCase _getConversationsUseCase;

  Future<void> loadMessages({bool force = false}) async {
    if (!force && state.status == MessagesStatus.loading) {
      return;
    }

    emit(state.copyWith(status: MessagesStatus.loading, clearFailure: true));

    final result = await _getConversationsUseCase.call(params: null);
    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(status: MessagesStatus.failure, failure: failure),
      ),
      ifRight: (conversations) => emit(
        state.copyWith(
          status: MessagesStatus.success,
          conversations: conversations,
          hiddenConversationIds: const {},
          clearFailure: true,
        ),
      ),
    );
  }

  void dismissConversation(int id) {
    final updated = Set<int>.from(state.hiddenConversationIds)..add(id);
    emit(state.copyWith(hiddenConversationIds: updated, clearFailure: true));
  }
}
