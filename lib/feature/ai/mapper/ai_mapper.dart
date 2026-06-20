import 'package:junior_football/feature/ai/data/models/chat_ai_response.dart';
import 'package:junior_football/feature/ai/data/models/injury_prediction_response.dart';
import 'package:junior_football/feature/ai/data/models/recent_ai_report_response.dart';
import 'package:junior_football/feature/ai/data/models/twin_player_response.dart';
import 'package:junior_football/feature/ai/domain/entity/chat_message_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/injury_prediction_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/recent_report_entity.dart';
import 'package:junior_football/feature/ai/domain/entity/twin_player_entity.dart';

extension RecentAiReportMapper on RecentAiReportResponse {
  RecentAiReportEntity toEntity() {
    return RecentAiReportEntity(
      id: id ?? "",
      drillType: drillType ?? "",
      overallScore: overallScore ?? 0,
      createdAt: createdAt ?? "",
      recommendations: recommendations ?? [],
      skills: (skills ?? Skills()).toEntity(),
      similarPlayerName: similarPlayerName ?? "",
      similarPlayerClub: similarPlayerClub ?? "",
      similarPlayerImageUrl: similarPlayerImageUrl ?? "",
    );
  }
}

extension SkillsMapper on Skills {
  SkillsEntity toEntity() {
    return SkillsEntity(
      speed: speed ?? 0,
      shooting: shooting ?? 0,
      passing: passing ?? 0,
      positioning: positioning ?? 0,
      reaction: reaction ?? 0,
    );
  }
}

extension InjuryPredictionMapper on InjuryPredictionResponse {
  InjuryPredictionEntity toEntity() {
    return InjuryPredictionEntity(
      title: title ?? "",
      advice: advice ?? "",
    );
  }
}

extension TwinPlayerMapper on TwinPlayerResponse {
  TwinPlayerEntity toEntity() {
    return TwinPlayerEntity(
      id: id,
      twinPlayerName: twinPlayerName,
      twinProfileImageUrl: twinProfileImageUrl,
      matchDescription: matchDescription,
      matchPercentage: matchPercentage,
      mediaGallery: mediaGallery?.map((e) => e.toEntity()).toList(),
    );
  }
}

extension MediaGalleryMapper on MediaGallery {
  MediaGalleryEntity toEntity() {
    return MediaGalleryEntity(
      title: title,
      url: url,
      mediaType: mediaType,
    );
  }
}

extension ChatAiResponseMapper on ChatAiResponse {
  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      text: answer ?? "",
      isUser: false,
    );
  }
}
