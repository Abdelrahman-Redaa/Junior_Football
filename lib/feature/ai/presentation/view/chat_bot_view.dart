import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_football/core/constants/app_assets.dart';
import 'package:junior_football/core/utilities/theme_extension.dart';
import 'package:junior_football/feature/ai/presentation/view_model/chat_state.dart';
import 'package:junior_football/feature/ai/presentation/view_model/chat_view_model.dart';
import 'package:junior_football/feature/ai/presentation/widget/message_sender_widget.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ai.chatTitle'.tr()), centerTitle: true),
      bottomNavigationBar: _TypeText(onSend: _scrollToBottom),
      body: SafeArea(
        child: BlocConsumer<ChatViewModel, ChatState>(
          listener: (context, state) {
            if (state.chatRequestState.isLoading ||
                state.chatRequestState.isLoaded) {
              _scrollToBottom();
            }
          },
          builder: (context, state) {
            final messages = state.messages;

            if (messages.isEmpty) {
              return const Center(child: _GetStarted());
            }

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount:
                  messages.length + (state.chatRequestState.isLoading ? 1 : 0),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                if (index < messages.length) {
                  final message = messages[index];
                  return MessageSenderWidget(
                    message: message.text,
                    isUser: message.isUser,
                  );
                } else {
                  return const _AiLoadingIndicator();
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class _AiLoadingIndicator extends StatelessWidget {
  const _AiLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(theme.primary),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "AI is thinking...",
              style: theme.medium14.copyWith(color: theme.primary),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeText extends StatefulWidget {
  final VoidCallback onSend;
  const _TypeText({required this.onSend});

  @override
  State<_TypeText> createState() => _TypeTextState();
}

class _TypeTextState extends State<_TypeText> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return BlocBuilder<ChatViewModel, ChatState>(
      builder: (context, state) {
        final isLoading = state.chatRequestState.isLoading;
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: theme.secondary,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: theme.neutral.withOpacity(0.1)),
                  ),
                  child: TextFormField(
                    controller: _textEditingController,
                    enabled: !isLoading,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: isLoading ? "AI is thinking..." : "Type your message...",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      suffixIcon: IconButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                final message = _textEditingController.text.trim();
                                if (message.isEmpty) return;
                                context.read<ChatViewModel>().doIntent(
                                      SendMessageIntent(message),
                                    );
                                _textEditingController.clear();
                                widget.onSend();
                              },
                        icon: isLoading 
                          ? const SizedBox(
                              width: 20, 
                              height: 20, 
                              child: CircularProgressIndicator(strokeWidth: 2)
                            )
                          : Icon(Icons.send_rounded, color: theme.primary),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GetStarted extends StatelessWidget {
  const _GetStarted();

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Image.asset(AppAssets.bot, height: 180),
          const SizedBox(height: 24),
          Text(
            "Start a Conversation",
            style: theme.semiBold24.copyWith(color: theme.neutral),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Ask about training, analysis, injury tips, or anything you need.",
              textAlign: TextAlign.center,
              style: theme.regular16.copyWith(
                color: theme.neutral.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
