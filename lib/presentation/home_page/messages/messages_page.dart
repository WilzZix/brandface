import 'package:brandface/core/constants/app_assets.dart';
import 'package:brandface/domain/entities/message/conversation_entity.dart';
import 'package:brandface/presentation/home_page/messages/bloc/messages_cubit.dart';
import 'package:brandface/presentation/home_page/messages/bloc/messages_state.dart';
import 'package:brandface/uikit/components/buttons/buttons.dart';
import 'package:brandface/uikit/tokens/colors.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  static const String tag = '/messages';

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessagesCubit, MessagesState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure && current.failure != null,
      listener: (context, state) {
        final failure = state.failure;
        if (failure == null || state.visibleConversations.isEmpty) {
          return;
        }

        final messenger = ScaffoldMessenger.of(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(failure.message)));
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBg,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.lightBg,

          titleSpacing: 4,
          title: Text('Messages', style: Typographies.titleLarge),
        ),
        body: SafeArea(
          top: false,
          child: BlocBuilder<MessagesCubit, MessagesState>(
            builder: (context, state) {
              final conversations = state.visibleConversations;

              if (state.status == MessagesStatus.loading &&
                  conversations.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == MessagesStatus.failure &&
                  conversations.isEmpty) {
                return _MessagesErrorState(
                  message:
                      state.failure?.message ?? 'Messages could not be loaded.',
                  onRetry: () =>
                      context.read<MessagesCubit>().loadMessages(force: true),
                );
              }

              return RefreshIndicator(
                color: AppColors.black,
                onRefresh: () =>
                    context.read<MessagesCubit>().loadMessages(force: true),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    MediaQuery.of(context).padding.bottom + 20,
                  ),
                  children: [
                    Text(
                      '${conversations.length} Messages found',
                      style: Typographies.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    if (state.status == MessagesStatus.loading)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: LinearProgressIndicator(minHeight: 2),
                      ),
                    if (conversations.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 140),
                        child: Center(child: Text('No messages yet.')),
                      )
                    else
                      ...List<Widget>.generate(conversations.length, (index) {
                        final item = conversations[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == conversations.length - 1 ? 0 : 16,
                          ),
                          child: _MessageCard(
                            conversation: item,
                            highlight: index == 0,
                            onDelete: () => context
                                .read<MessagesCubit>()
                                .dismissConversation(item.id),
                          ),
                        );
                      }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    required this.conversation,
    required this.highlight,
    required this.onDelete,
  });

  final ConversationEntity conversation;
  final bool highlight;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final participant = conversation.counterpart;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: highlight ? AppColors.lightGreen : AppColors.lightBg3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _buildHeader(participant),
            style: Typographies.titleSmall.copyWith(
              color: AppColors.mutedBlack,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  _buildSubheader(conversation, participant),
                  style: Typographies.titleLarge.copyWith(
                    fontSize: 18,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                participant?.phoneNumber.trim().isNotEmpty == true
                    ? participant!.phoneNumber
                    : 'No phone',
                style: Typographies.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: AppColors.borderColor.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Text(
            _buildPreview(conversation),
            style: Typographies.bodySmall.copyWith(height: 1.35),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onDelete,
            child: Text(
              'Delete',
              style: Typographies.labelLarge.copyWith(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }

  String _buildHeader(ConversationParticipantEntity? participant) {
    final role = participant?.role.trim().toLowerCase();
    if (role == null || role.isEmpty) {
      return 'Participant';
    }

    if (role == 'brand') {
      return 'Brand contact';
    }

    if (role == 'influencer') {
      return 'Influencer contact';
    }

    return '${role[0].toUpperCase()}${role.substring(1)} contact';
  }

  String _buildSubheader(
    ConversationEntity item,
    ConversationParticipantEntity? participant,
  ) {
    if (item.offerId != null) {
      return 'Offer #${item.offerId}';
    }

    final role = participant?.role.trim().toLowerCase();
    if (role == 'brand') {
      return 'Brand conversation';
    }

    if (role == 'influencer') {
      return 'Influencer conversation';
    }

    if (participant != null) {
      return 'Conversation #${participant.id}';
    }

    return 'Conversation';
  }

  String _buildPreview(ConversationEntity item) {
    final text = item.lastMessage?.trim();
    if (text != null && text.isNotEmpty) {
      return text;
    }

    return 'No messages yet in this conversation.';
  }
}

class _MessagesErrorState extends StatelessWidget {
  const _MessagesErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Typographies.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Pull to refresh or try again.',
              style: Typographies.bodyMedium.copyWith(color: AppColors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 170,
              child: AppButtons.primary(title: 'Try again', onTap: onRetry),
            ),
          ],
        ),
      ),
    );
  }
}
