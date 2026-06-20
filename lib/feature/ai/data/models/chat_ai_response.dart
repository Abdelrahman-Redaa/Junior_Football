import 'package:json_annotation/json_annotation.dart';

part 'chat_ai_response.g.dart';

@JsonSerializable()
class ChatAiResponse {
  @JsonKey(name: "answer")
  final String? answer;

  ChatAiResponse ({
    this.answer,
  });

  factory ChatAiResponse.fromJson(Map<String, dynamic> json) {
    return _$ChatAiResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ChatAiResponseToJson(this);
  }
}


