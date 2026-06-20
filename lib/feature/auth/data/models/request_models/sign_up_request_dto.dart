import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_dto.g.dart';

@JsonSerializable()
class SignupRequestDto {
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "dateOfBirth")
  final String? dateOfBirth;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "playingPosition")
  final int? playingPosition;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;

  const SignupRequestDto({
    this.fullName,
    this.dateOfBirth,
    this.country,
    this.playingPosition,
    this.email,
    this.password,
  });

  factory SignupRequestDto.fromJson(Map<String, dynamic> json) {
    return _$SignupRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignupRequestDtoToJson(this);
  }
}
