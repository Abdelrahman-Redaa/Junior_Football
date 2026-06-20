import 'package:injectable/injectable.dart';
import 'package:junior_football/core/base_bloc/base_cubit.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/core/error_handling/result.dart';
import 'package:junior_football/feature/ai/domain/entity/chat_message_entity.dart';
import 'package:junior_football/feature/ai/domain/repo/ai_repo.dart';
import 'package:junior_football/feature/ai/presentation/view_model/chat_state.dart';

@injectable
class ChatViewModel extends BaseCubit<ChatState, ChatIntent, ChatEvent> {
  final AiRepo _aiRepo;

  ChatViewModel(this._aiRepo)
      : super(
          ChatState(
            messages:  [],
            chatRequestState: BaseState.init(),
          ),
        );

  @override
  void doIntent(ChatIntent intent) {
    switch (intent) {
      case SendMessageIntent():
        _sendMessage(intent.message);
    }
  }

  Future<void> _sendMessage(String message) async {
    final userMessage = ChatMessageEntity(text: message, isUser: true);
    final currentMessages = List<ChatMessageEntity>.from(state.messages);
    currentMessages.add(userMessage);
    
    emit(state.copyWith(
      messages: currentMessages,
      chatRequestState: BaseState.loading(),
    ));

    final result = await _aiRepo.chatAi(message);

    switch (result) {
      case Success<ChatMessageEntity>():
        final aiMessages = List<ChatMessageEntity>.from(state.messages);
        aiMessages.add(result.data);
        emit(state.copyWith(
          messages: aiMessages,
          chatRequestState: BaseState.loaded(result.data),
        ));
      case Failure<ChatMessageEntity>():
        emit(state.copyWith(
          chatRequestState: BaseState.error(result.errorMessage),
        ));
    }
  }
}
