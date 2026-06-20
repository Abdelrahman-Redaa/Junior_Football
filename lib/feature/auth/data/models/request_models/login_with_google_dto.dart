import 'package:json_annotation/json_annotation.dart';
part 'login_with_google_dto.g.dart';

@JsonSerializable()
class GoogleLoginRequest {
  @JsonKey(name: 'idToken')
  final String? idToken;
  const GoogleLoginRequest({required this.idToken});

  factory GoogleLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleLoginRequestToJson(this);
}
