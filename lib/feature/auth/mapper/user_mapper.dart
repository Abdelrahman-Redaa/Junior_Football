import 'package:junior_football/feature/auth/data/models/response_models/user_info_dto.dart';
import 'package:junior_football/feature/auth/domain/entities/user_entity.dart';

extension UserMapper on UserInfoDto {
  UserEntity toEntity() => UserEntity(
    email: user?.email,
    id: user?.id,
    fullName: user?.fullName,
    token: token,
  );
}
