import 'training_dashboard.dart';

class TrainingWeeklyPlanResponse {
  final String? weekStartDate;
  final String? weekEndDate;
  final int? completedDays;
  final int? totalDays;
  final num? completionProgress;
  final int? totalXpAvailable;
  final int? totalXpEarned;
  final List<TrainingWeeklyDayResponse>? days;

  const TrainingWeeklyPlanResponse({
    this.weekStartDate,
    this.weekEndDate,
    this.completedDays,
    this.totalDays,
    this.completionProgress,
    this.totalXpAvailable,
    this.totalXpEarned,
    this.days,
  });

  factory TrainingWeeklyPlanResponse.fromJson(Map<String, dynamic> json) {
    return TrainingWeeklyPlanResponse(
      weekStartDate: json['weekStartDate'] as String?,
      weekEndDate: json['weekEndDate'] as String?,
      completedDays: (json['completedDays'] as num?)?.toInt(),
      totalDays: (json['totalDays'] as num?)?.toInt(),
      completionProgress: json['completionProgress'] as num?,
      totalXpAvailable: (json['totalXpAvailable'] as num?)?.toInt(),
      totalXpEarned: (json['totalXpEarned'] as num?)?.toInt(),
      days: (json['days'] as List<dynamic>?)
          ?.map(
            (e) =>
                TrainingWeeklyDayResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class TrainingWeeklyDayResponse {
  final String? planId;
  final String? day;
  final String? dayShort;
  final String? date;
  final bool? isToday;
  final bool? isCompleted;
  final bool? hasSession;
  final bool? isRestDay;
  final int? xpEarned;
  final TodaySession? session;

  const TrainingWeeklyDayResponse({
    this.planId,
    this.day,
    this.dayShort,
    this.date,
    this.isToday,
    this.isCompleted,
    this.hasSession,
    this.isRestDay,
    this.xpEarned,
    this.session,
  });

  factory TrainingWeeklyDayResponse.fromJson(Map<String, dynamic> json) {
    return TrainingWeeklyDayResponse(
      planId: json['planId'] as String?,
      day: json['day'] as String?,
      dayShort: json['dayShort'] as String?,
      date: json['date'] as String?,
      isToday: json['isToday'] as bool?,
      isCompleted: json['isCompleted'] as bool?,
      hasSession: json['hasSession'] as bool?,
      isRestDay: json['isRestDay'] as bool?,
      xpEarned: (json['xpEarned'] as num?)?.toInt(),
      session: json['session'] == null
          ? null
          : TodaySession.fromJson(json['session'] as Map<String, dynamic>),
    );
  }
}
