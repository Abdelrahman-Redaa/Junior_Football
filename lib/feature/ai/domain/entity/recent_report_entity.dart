
class RecentAiReportEntity {
  final String id;
  final String drillType;
  final int overallScore;
  final String createdAt;
  final List<String> recommendations;
  final SkillsEntity skills;
  final String similarPlayerName;
  final String similarPlayerClub;
  final String similarPlayerImageUrl;

  RecentAiReportEntity({
    required this.id,
    required this.drillType,
    required this.overallScore,
    required this.createdAt,
    required this.recommendations,
    required this.skills,
    required this.similarPlayerName,
    required this.similarPlayerClub,
    required this.similarPlayerImageUrl,
  });
}

class SkillsEntity {
  final int speed;
  final int shooting;
  final int passing;
  final int positioning;
  final int reaction;

  SkillsEntity({
    required this.speed,
    required this.shooting,
    required this.passing,
    required this.positioning,
    required this.reaction,
  });
}