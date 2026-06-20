import 'package:equatable/equatable.dart';
import 'package:junior_football/core/base_bloc/base_state.dart';
import 'package:junior_football/feature/ai/domain/entity/chat_message_entity.dart';

class ChatState extends Equatable {
  final List<ChatMessageEntity> messages;
  final BaseState<ChatMessageEntity> chatRequestState;

  const ChatState({
    required this.messages,
    required this.chatRequestState,
  });

  ChatState copyWith({
    List<ChatMessageEntity>? messages,
    BaseState<ChatMessageEntity>? chatRequestState,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      chatRequestState: chatRequestState ?? this.chatRequestState,
    );
  }

  @override
  List<Object?> get props => [messages, chatRequestState];
}

sealed class ChatIntent {}

class SendMessageIntent extends ChatIntent {
  final String message;
  SendMessageIntent(this.message);
}

sealed class ChatEvent {}
