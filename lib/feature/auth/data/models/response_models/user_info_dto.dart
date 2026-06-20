import 'package:json_annotation/json_annotation.dart';

part 'user_info_dto.g.dart';

@JsonSerializable()
class UserInfoDto {
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "user")
  final User? user;

  UserInfoDto({this.token, this.user});

  factory UserInfoDto.fromJson(Map<String, dynamic> json) {
    return _$UserInfoDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserInfoDtoToJson(this);
  }
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "full_name")
  final String? fullName;
  @JsonKey(name: "email")
  final String? email;

  User({this.id, this.fullName, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserToJson(this);
  }
}
