import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,

    @TimestampConverter()
    required DateTime createdAt,

    SmokingProfile? smokingProfile,

    @Default([])
    List<String> quitReasons,

    String? customQuitReason,
    SavingsTarget? savingsTarget, // Keeping for backwards compatibility/migration step

    @Default([])
    List<SavingsTarget> savingsTargets,

    @TimestampConverter()
    DateTime? quitDate,

    ProgressSummary? progressSummary,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class SmokingProfile with _$SmokingProfile {
  const factory SmokingProfile({
    @Default('') String brand,
    @Default('') String variant,
    @Default(0) double pricePerPack,
    @Default(0) int cigarettesPerPack,
    @Default(0) int cigarettesPerDay,
    @Default(0) int yearsSmoking,
  }) = _SmokingProfile;

  factory SmokingProfile.fromJson(Map<String, dynamic> json) =>
      _$SmokingProfileFromJson(json);
}

@freezed
class SavingsTarget with _$SavingsTarget {
  const factory SavingsTarget({
    @Default('') String itemName,
    @Default(0) double targetPrice,
    String? imageUrl,
  }) = _SavingsTarget;

  factory SavingsTarget.fromJson(Map<String, dynamic> json) =>
      _$SavingsTargetFromJson(json);
}

@freezed
class ProgressSummary with _$ProgressSummary {
  const factory ProgressSummary({
    @Default(0) int currentStreak,
    @Default(0) int longestStreak,
    @Default(0) double totalMoneySaved,
    @Default(0) int cigarettesAvoided,
    @Default(0) int totalDaysSmokeFree,
    @Default(0) int relapseCount,
    @Default(0) int totalSlips,
    @Default(0) int todaySlips,
    @TimestampConverter() DateTime? lastSlipDate,

    @TimestampConverter()
    DateTime? lastCheckInDate,
  }) = _ProgressSummary;

  factory ProgressSummary.fromJson(Map<String, dynamic> json) =>
      _$ProgressSummaryFromJson(json);
}