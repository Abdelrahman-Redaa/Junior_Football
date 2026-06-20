import 'package:json_annotation/json_annotation.dart';

part 'weekly_process_response.g.dart';

@JsonSerializable()
class WeeklyProcessResponse {
  @JsonKey(name: "totalXp")
  final int? totalXp;
  @JsonKey(name: "totalSessionsCount")
  final int? totalSessionsCount;
  @JsonKey(name: "weeklyProgress")
  final List<WeeklyProgress>? weeklyProgress;

  WeeklyProcessResponse ({
    this.totalXp,
    this.totalSessionsCount,
    this.weeklyProgress,
  });

  factory WeeklyProcessResponse.fromJson(Map<String, dynamic> json) {
    return _$WeeklyProcessResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WeeklyProcessResponseToJson(this);
  }
}

@JsonSerializable()
class WeeklyProgress {
  @JsonKey(name: "dayName")
  final String? dayName;
  @JsonKey(name: "xpEarned")
  final int? xpEarned;

  WeeklyProgress ({
    this.dayName,
    this.xpEarned,
  });

  factory WeeklyProgress.fromJson(Map<String, dynamic> json) {
    return _$WeeklyProgressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WeeklyProgressToJson(this);
  }
}


