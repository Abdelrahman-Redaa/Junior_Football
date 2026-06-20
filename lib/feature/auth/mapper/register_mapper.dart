import 'package:junior_football/feature/auth/data/models/response_models/register_response.dart';
import 'package:junior_football/feature/auth/domain/entities/register_entity.dart';

extension RegisterMapper on RegisterResponse{
  RegisterEntity toEntity() => RegisterEntity(
    message: message,
    isSuccess: isSuccess,
  );
}