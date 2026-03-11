// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      smokingProfile: json['smokingProfile'] == null
          ? null
          : SmokingProfile.fromJson(
              json['smokingProfile'] as Map<String, dynamic>),
      quitReasons: (json['quitReasons'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      customQuitReason: json['customQuitReason'] as String?,
      savingsTarget: json['savingsTarget'] == null
          ? null
          : SavingsTarget.fromJson(
              json['savingsTarget'] as Map<String, dynamic>),
      savingsTargets: (json['savingsTargets'] as List<dynamic>?)
              ?.map((e) => SavingsTarget.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      quitDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['quitDate'], const TimestampConverter().fromJson),
      progressSummary: json['progressSummary'] == null
          ? null
          : ProgressSummary.fromJson(
              json['progressSummary'] as Map<String, dynamic>),
      currency: json['currency'] as String? ?? 'IDR',
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'smokingProfile': instance.smokingProfile?.toJson(),
      'quitReasons': instance.quitReasons,
      'customQuitReason': instance.customQuitReason,
      'savingsTarget': instance.savingsTarget?.toJson(),
      'savingsTargets': instance.savingsTargets.map((e) => e.toJson()).toList(),
      'quitDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.quitDate, const TimestampConverter().toJson),
      'progressSummary': instance.progressSummary?.toJson(),
      'currency': instance.currency,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$SmokingProfileImpl _$$SmokingProfileImplFromJson(Map<String, dynamic> json) =>
    _$SmokingProfileImpl(
      brand: json['brand'] as String? ?? '',
      variant: json['variant'] as String? ?? '',
      pricePerPack: (json['pricePerPack'] as num?)?.toDouble() ?? 0,
      cigarettesPerPack: (json['cigarettesPerPack'] as num?)?.toInt() ?? 0,
      cigarettesPerDay: (json['cigarettesPerDay'] as num?)?.toInt() ?? 0,
      yearsSmoking: (json['yearsSmoking'] as num?)?.toInt() ?? 0,
      profileHistory: json['profileHistory'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$$SmokingProfileImplToJson(
        _$SmokingProfileImpl instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'variant': instance.variant,
      'pricePerPack': instance.pricePerPack,
      'cigarettesPerPack': instance.cigarettesPerPack,
      'cigarettesPerDay': instance.cigarettesPerDay,
      'yearsSmoking': instance.yearsSmoking,
      'profileHistory': instance.profileHistory,
    };

_$SavingsTargetImpl _$$SavingsTargetImplFromJson(Map<String, dynamic> json) =>
    _$SavingsTargetImpl(
      itemName: json['itemName'] as String? ?? '',
      targetPrice: (json['targetPrice'] as num?)?.toDouble() ?? 0,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$SavingsTargetImplToJson(_$SavingsTargetImpl instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'targetPrice': instance.targetPrice,
      'imageUrl': instance.imageUrl,
    };

_$ProgressSummaryImpl _$$ProgressSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$ProgressSummaryImpl(
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      totalMoneySaved: (json['totalMoneySaved'] as num?)?.toDouble() ?? 0,
      cigarettesAvoided: (json['cigarettesAvoided'] as num?)?.toInt() ?? 0,
      totalDaysSmokeFree: (json['totalDaysSmokeFree'] as num?)?.toInt() ?? 0,
      relapseCount: (json['relapseCount'] as num?)?.toInt() ?? 0,
      totalSlips: (json['totalSlips'] as num?)?.toInt() ?? 0,
      todaySlips: (json['todaySlips'] as num?)?.toInt() ?? 0,
      slipHistory: json['slipHistory'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
      lastSlipDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastSlipDate'], const TimestampConverter().fromJson),
      lastCheckInDate: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastCheckInDate'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$ProgressSummaryImplToJson(
        _$ProgressSummaryImpl instance) =>
    <String, dynamic>{
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'totalMoneySaved': instance.totalMoneySaved,
      'cigarettesAvoided': instance.cigarettesAvoided,
      'totalDaysSmokeFree': instance.totalDaysSmokeFree,
      'relapseCount': instance.relapseCount,
      'totalSlips': instance.totalSlips,
      'todaySlips': instance.todaySlips,
      'slipHistory': instance.slipHistory,
      'lastSlipDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastSlipDate, const TimestampConverter().toJson),
      'lastCheckInDate': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastCheckInDate, const TimestampConverter().toJson),
    };
