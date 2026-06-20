class AnalysisEntity {
  final String message;
  final DataEntity data;

  AnalysisEntity({required this.message, required this.data});
}

class DataEntity {
  final SkillsEntity skills;
  final String advice;

  DataEntity({required this.skills, required this.advice});
  Map<String, String> parseScoutReport() {
    final Map<String, String> result = {};

    // remove main title
    final cleanedReport = advice.replaceFirst("### Scout Report", "");

    // split sections
    final sections = cleanedReport.split("####");

    for (final section in sections) {
      if (section.trim().isEmpty) continue;

      final lines = section.trim().split("\n");

      final key = lines.first.trim();

      final value = lines.skip(1).join("\n").trim().replaceAll(r'\n', '\n');

      result[key] = value;
    }

    return result;
  }
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

  double get overAll =>
      (speed + shooting + passing + positioning + reaction) / 5;
}
