import 'package:json_annotation/json_annotation.dart';

part 'full_weekly_plan_response.g.dart';

@JsonSerializable()
class FullWeeklyPlanResponse {
  @JsonKey(name: "dayName")
  final String? dayName;
  @JsonKey(name: "isToday")
  final bool? isToday;
  @JsonKey(name: "sessions")
  final List<Sessions>? sessions;

  FullWeeklyPlanResponse ({
    this.dayName,
    this.isToday,
    this.sessions,
  });

  factory FullWeeklyPlanResponse.fromJson(Map<String, dynamic> json) {
    return _$FullWeeklyPlanResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$FullWeeklyPlanResponseToJson(this);
  }
}

@JsonSerializable()
class Sessions {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "expectedDurationMinutes")
  final int? expectedDurationMinutes;
  @JsonKey(name: "rewardXp")
  final int? rewardXp;
  @JsonKey(name: "thumbnailUrl")
  final String? thumbnailUrl;
  @JsonKey(name: "isCompleted")
  final bool? isCompleted;
  @JsonKey(name: "drills")
  final List<Drills>? drills;

  Sessions ({
    this.id,
    this.title,
    this.description,
    this.expectedDurationMinutes,
    this.rewardXp,
    this.thumbnailUrl,
    this.isCompleted,
    this.drills,
  });

  factory Sessions.fromJson(Map<String, dynamic> json) {
    return _$SessionsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SessionsToJson(this);
  }
}

@JsonSerializable()
class Drills {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "repetitions")
  final int? repetitions;
  @JsonKey(name: "videoUrl")
  final String? videoUrl;
  @JsonKey(name: "orderIndex")
  final int? orderIndex;

  Drills ({
    this.id,
    this.title,
    this.description,
    this.repetitions,
    this.videoUrl,
    this.orderIndex,
  });

  factory Drills.fromJson(Map<String, dynamic> json) {
    return _$DrillsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DrillsToJson(this);
  }
}


