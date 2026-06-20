import 'package:junior_football/feature/community/data/models/created_response.dart';
import 'package:junior_football/feature/community/domain/entity/liked_post_entity.dart';

extension LikedPostMapper on CreatedResponse {
  LikedPostEntity toEntity() {
    return LikedPostEntity(
      isSuccess: isSuccess ?? false,
      message: message ?? "",
    );
  }
}
