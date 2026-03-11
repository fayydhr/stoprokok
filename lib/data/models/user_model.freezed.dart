// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  SmokingProfile? get smokingProfile => throw _privateConstructorUsedError;
  List<String> get quitReasons => throw _privateConstructorUsedError;
  String? get customQuitReason => throw _privateConstructorUsedError;
  SavingsTarget? get savingsTarget =>
      throw _privateConstructorUsedError; // Keeping for backwards compatibility/migration step
  List<SavingsTarget> get savingsTargets => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get quitDate => throw _privateConstructorUsedError;
  ProgressSummary? get progressSummary => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      @TimestampConverter() DateTime createdAt,
      SmokingProfile? smokingProfile,
      List<String> quitReasons,
      String? customQuitReason,
      SavingsTarget? savingsTarget,
      List<SavingsTarget> savingsTargets,
      @TimestampConverter() DateTime? quitDate,
      ProgressSummary? progressSummary,
      String currency});

  $SmokingProfileCopyWith<$Res>? get smokingProfile;
  $SavingsTargetCopyWith<$Res>? get savingsTarget;
  $ProgressSummaryCopyWith<$Res>? get progressSummary;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? createdAt = null,
    Object? smokingProfile = freezed,
    Object? quitReasons = null,
    Object? customQuitReason = freezed,
    Object? savingsTarget = freezed,
    Object? savingsTargets = null,
    Object? quitDate = freezed,
    Object? progressSummary = freezed,
    Object? currency = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      smokingProfile: freezed == smokingProfile
          ? _value.smokingProfile
          : smokingProfile // ignore: cast_nullable_to_non_nullable
              as SmokingProfile?,
      quitReasons: null == quitReasons
          ? _value.quitReasons
          : quitReasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customQuitReason: freezed == customQuitReason
          ? _value.customQuitReason
          : customQuitReason // ignore: cast_nullable_to_non_nullable
              as String?,
      savingsTarget: freezed == savingsTarget
          ? _value.savingsTarget
          : savingsTarget // ignore: cast_nullable_to_non_nullable
              as SavingsTarget?,
      savingsTargets: null == savingsTargets
          ? _value.savingsTargets
          : savingsTargets // ignore: cast_nullable_to_non_nullable
              as List<SavingsTarget>,
      quitDate: freezed == quitDate
          ? _value.quitDate
          : quitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      progressSummary: freezed == progressSummary
          ? _value.progressSummary
          : progressSummary // ignore: cast_nullable_to_non_nullable
              as ProgressSummary?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SmokingProfileCopyWith<$Res>? get smokingProfile {
    if (_value.smokingProfile == null) {
      return null;
    }

    return $SmokingProfileCopyWith<$Res>(_value.smokingProfile!, (value) {
      return _then(_value.copyWith(smokingProfile: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SavingsTargetCopyWith<$Res>? get savingsTarget {
    if (_value.savingsTarget == null) {
      return null;
    }

    return $SavingsTargetCopyWith<$Res>(_value.savingsTarget!, (value) {
      return _then(_value.copyWith(savingsTarget: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProgressSummaryCopyWith<$Res>? get progressSummary {
    if (_value.progressSummary == null) {
      return null;
    }

    return $ProgressSummaryCopyWith<$Res>(_value.progressSummary!, (value) {
      return _then(_value.copyWith(progressSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String email,
      @TimestampConverter() DateTime createdAt,
      SmokingProfile? smokingProfile,
      List<String> quitReasons,
      String? customQuitReason,
      SavingsTarget? savingsTarget,
      List<SavingsTarget> savingsTargets,
      @TimestampConverter() DateTime? quitDate,
      ProgressSummary? progressSummary,
      String currency});

  @override
  $SmokingProfileCopyWith<$Res>? get smokingProfile;
  @override
  $SavingsTargetCopyWith<$Res>? get savingsTarget;
  @override
  $ProgressSummaryCopyWith<$Res>? get progressSummary;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
    Object? createdAt = null,
    Object? smokingProfile = freezed,
    Object? quitReasons = null,
    Object? customQuitReason = freezed,
    Object? savingsTarget = freezed,
    Object? savingsTargets = null,
    Object? quitDate = freezed,
    Object? progressSummary = freezed,
    Object? currency = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      smokingProfile: freezed == smokingProfile
          ? _value.smokingProfile
          : smokingProfile // ignore: cast_nullable_to_non_nullable
              as SmokingProfile?,
      quitReasons: null == quitReasons
          ? _value._quitReasons
          : quitReasons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customQuitReason: freezed == customQuitReason
          ? _value.customQuitReason
          : customQuitReason // ignore: cast_nullable_to_non_nullable
              as String?,
      savingsTarget: freezed == savingsTarget
          ? _value.savingsTarget
          : savingsTarget // ignore: cast_nullable_to_non_nullable
              as SavingsTarget?,
      savingsTargets: null == savingsTargets
          ? _value._savingsTargets
          : savingsTargets // ignore: cast_nullable_to_non_nullable
              as List<SavingsTarget>,
      quitDate: freezed == quitDate
          ? _value.quitDate
          : quitDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      progressSummary: freezed == progressSummary
          ? _value.progressSummary
          : progressSummary // ignore: cast_nullable_to_non_nullable
              as ProgressSummary?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.name,
      required this.email,
      @TimestampConverter() required this.createdAt,
      this.smokingProfile,
      final List<String> quitReasons = const [],
      this.customQuitReason,
      this.savingsTarget,
      final List<SavingsTarget> savingsTargets = const [],
      @TimestampConverter() this.quitDate,
      this.progressSummary,
      this.currency = 'IDR'})
      : _quitReasons = quitReasons,
        _savingsTargets = savingsTargets;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  final SmokingProfile? smokingProfile;
  final List<String> _quitReasons;
  @override
  @JsonKey()
  List<String> get quitReasons {
    if (_quitReasons is EqualUnmodifiableListView) return _quitReasons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quitReasons);
  }

  @override
  final String? customQuitReason;
  @override
  final SavingsTarget? savingsTarget;
// Keeping for backwards compatibility/migration step
  final List<SavingsTarget> _savingsTargets;
// Keeping for backwards compatibility/migration step
  @override
  @JsonKey()
  List<SavingsTarget> get savingsTargets {
    if (_savingsTargets is EqualUnmodifiableListView) return _savingsTargets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savingsTargets);
  }

  @override
  @TimestampConverter()
  final DateTime? quitDate;
  @override
  final ProgressSummary? progressSummary;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, createdAt: $createdAt, smokingProfile: $smokingProfile, quitReasons: $quitReasons, customQuitReason: $customQuitReason, savingsTarget: $savingsTarget, savingsTargets: $savingsTargets, quitDate: $quitDate, progressSummary: $progressSummary, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.smokingProfile, smokingProfile) ||
                other.smokingProfile == smokingProfile) &&
            const DeepCollectionEquality()
                .equals(other._quitReasons, _quitReasons) &&
            (identical(other.customQuitReason, customQuitReason) ||
                other.customQuitReason == customQuitReason) &&
            (identical(other.savingsTarget, savingsTarget) ||
                other.savingsTarget == savingsTarget) &&
            const DeepCollectionEquality()
                .equals(other._savingsTargets, _savingsTargets) &&
            (identical(other.quitDate, quitDate) ||
                other.quitDate == quitDate) &&
            (identical(other.progressSummary, progressSummary) ||
                other.progressSummary == progressSummary) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      email,
      createdAt,
      smokingProfile,
      const DeepCollectionEquality().hash(_quitReasons),
      customQuitReason,
      savingsTarget,
      const DeepCollectionEquality().hash(_savingsTargets),
      quitDate,
      progressSummary,
      currency);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String name,
      required final String email,
      @TimestampConverter() required final DateTime createdAt,
      final SmokingProfile? smokingProfile,
      final List<String> quitReasons,
      final String? customQuitReason,
      final SavingsTarget? savingsTarget,
      final List<SavingsTarget> savingsTargets,
      @TimestampConverter() final DateTime? quitDate,
      final ProgressSummary? progressSummary,
      final String currency}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  SmokingProfile? get smokingProfile;
  @override
  List<String> get quitReasons;
  @override
  String? get customQuitReason;
  @override
  SavingsTarget?
      get savingsTarget; // Keeping for backwards compatibility/migration step
  @override
  List<SavingsTarget> get savingsTargets;
  @override
  @TimestampConverter()
  DateTime? get quitDate;
  @override
  ProgressSummary? get progressSummary;
  @override
  String get currency;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmokingProfile _$SmokingProfileFromJson(Map<String, dynamic> json) {
  return _SmokingProfile.fromJson(json);
}

/// @nodoc
mixin _$SmokingProfile {
  String get brand => throw _privateConstructorUsedError;
  String get variant => throw _privateConstructorUsedError;
  double get pricePerPack => throw _privateConstructorUsedError;
  int get cigarettesPerPack => throw _privateConstructorUsedError;
  int get cigarettesPerDay => throw _privateConstructorUsedError;
  int get yearsSmoking => throw _privateConstructorUsedError;
  Map<String, dynamic> get profileHistory => throw _privateConstructorUsedError;

  /// Serializes this SmokingProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmokingProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmokingProfileCopyWith<SmokingProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmokingProfileCopyWith<$Res> {
  factory $SmokingProfileCopyWith(
          SmokingProfile value, $Res Function(SmokingProfile) then) =
      _$SmokingProfileCopyWithImpl<$Res, SmokingProfile>;
  @useResult
  $Res call(
      {String brand,
      String variant,
      double pricePerPack,
      int cigarettesPerPack,
      int cigarettesPerDay,
      int yearsSmoking,
      Map<String, dynamic> profileHistory});
}

/// @nodoc
class _$SmokingProfileCopyWithImpl<$Res, $Val extends SmokingProfile>
    implements $SmokingProfileCopyWith<$Res> {
  _$SmokingProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmokingProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = null,
    Object? variant = null,
    Object? pricePerPack = null,
    Object? cigarettesPerPack = null,
    Object? cigarettesPerDay = null,
    Object? yearsSmoking = null,
    Object? profileHistory = null,
  }) {
    return _then(_value.copyWith(
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String,
      pricePerPack: null == pricePerPack
          ? _value.pricePerPack
          : pricePerPack // ignore: cast_nullable_to_non_nullable
              as double,
      cigarettesPerPack: null == cigarettesPerPack
          ? _value.cigarettesPerPack
          : cigarettesPerPack // ignore: cast_nullable_to_non_nullable
              as int,
      cigarettesPerDay: null == cigarettesPerDay
          ? _value.cigarettesPerDay
          : cigarettesPerDay // ignore: cast_nullable_to_non_nullable
              as int,
      yearsSmoking: null == yearsSmoking
          ? _value.yearsSmoking
          : yearsSmoking // ignore: cast_nullable_to_non_nullable
              as int,
      profileHistory: null == profileHistory
          ? _value.profileHistory
          : profileHistory // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmokingProfileImplCopyWith<$Res>
    implements $SmokingProfileCopyWith<$Res> {
  factory _$$SmokingProfileImplCopyWith(_$SmokingProfileImpl value,
          $Res Function(_$SmokingProfileImpl) then) =
      __$$SmokingProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String brand,
      String variant,
      double pricePerPack,
      int cigarettesPerPack,
      int cigarettesPerDay,
      int yearsSmoking,
      Map<String, dynamic> profileHistory});
}

/// @nodoc
class __$$SmokingProfileImplCopyWithImpl<$Res>
    extends _$SmokingProfileCopyWithImpl<$Res, _$SmokingProfileImpl>
    implements _$$SmokingProfileImplCopyWith<$Res> {
  __$$SmokingProfileImplCopyWithImpl(
      _$SmokingProfileImpl _value, $Res Function(_$SmokingProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of SmokingProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = null,
    Object? variant = null,
    Object? pricePerPack = null,
    Object? cigarettesPerPack = null,
    Object? cigarettesPerDay = null,
    Object? yearsSmoking = null,
    Object? profileHistory = null,
  }) {
    return _then(_$SmokingProfileImpl(
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      variant: null == variant
          ? _value.variant
          : variant // ignore: cast_nullable_to_non_nullable
              as String,
      pricePerPack: null == pricePerPack
          ? _value.pricePerPack
          : pricePerPack // ignore: cast_nullable_to_non_nullable
              as double,
      cigarettesPerPack: null == cigarettesPerPack
          ? _value.cigarettesPerPack
          : cigarettesPerPack // ignore: cast_nullable_to_non_nullable
              as int,
      cigarettesPerDay: null == cigarettesPerDay
          ? _value.cigarettesPerDay
          : cigarettesPerDay // ignore: cast_nullable_to_non_nullable
              as int,
      yearsSmoking: null == yearsSmoking
          ? _value.yearsSmoking
          : yearsSmoking // ignore: cast_nullable_to_non_nullable
              as int,
      profileHistory: null == profileHistory
          ? _value._profileHistory
          : profileHistory // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmokingProfileImpl implements _SmokingProfile {
  const _$SmokingProfileImpl(
      {this.brand = '',
      this.variant = '',
      this.pricePerPack = 0,
      this.cigarettesPerPack = 0,
      this.cigarettesPerDay = 0,
      this.yearsSmoking = 0,
      final Map<String, dynamic> profileHistory = const <String, dynamic>{}})
      : _profileHistory = profileHistory;

  factory _$SmokingProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmokingProfileImplFromJson(json);

  @override
  @JsonKey()
  final String brand;
  @override
  @JsonKey()
  final String variant;
  @override
  @JsonKey()
  final double pricePerPack;
  @override
  @JsonKey()
  final int cigarettesPerPack;
  @override
  @JsonKey()
  final int cigarettesPerDay;
  @override
  @JsonKey()
  final int yearsSmoking;
  final Map<String, dynamic> _profileHistory;
  @override
  @JsonKey()
  Map<String, dynamic> get profileHistory {
    if (_profileHistory is EqualUnmodifiableMapView) return _profileHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_profileHistory);
  }

  @override
  String toString() {
    return 'SmokingProfile(brand: $brand, variant: $variant, pricePerPack: $pricePerPack, cigarettesPerPack: $cigarettesPerPack, cigarettesPerDay: $cigarettesPerDay, yearsSmoking: $yearsSmoking, profileHistory: $profileHistory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmokingProfileImpl &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.variant, variant) || other.variant == variant) &&
            (identical(other.pricePerPack, pricePerPack) ||
                other.pricePerPack == pricePerPack) &&
            (identical(other.cigarettesPerPack, cigarettesPerPack) ||
                other.cigarettesPerPack == cigarettesPerPack) &&
            (identical(other.cigarettesPerDay, cigarettesPerDay) ||
                other.cigarettesPerDay == cigarettesPerDay) &&
            (identical(other.yearsSmoking, yearsSmoking) ||
                other.yearsSmoking == yearsSmoking) &&
            const DeepCollectionEquality()
                .equals(other._profileHistory, _profileHistory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      brand,
      variant,
      pricePerPack,
      cigarettesPerPack,
      cigarettesPerDay,
      yearsSmoking,
      const DeepCollectionEquality().hash(_profileHistory));

  /// Create a copy of SmokingProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmokingProfileImplCopyWith<_$SmokingProfileImpl> get copyWith =>
      __$$SmokingProfileImplCopyWithImpl<_$SmokingProfileImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmokingProfileImplToJson(
      this,
    );
  }
}

abstract class _SmokingProfile implements SmokingProfile {
  const factory _SmokingProfile(
      {final String brand,
      final String variant,
      final double pricePerPack,
      final int cigarettesPerPack,
      final int cigarettesPerDay,
      final int yearsSmoking,
      final Map<String, dynamic> profileHistory}) = _$SmokingProfileImpl;

  factory _SmokingProfile.fromJson(Map<String, dynamic> json) =
      _$SmokingProfileImpl.fromJson;

  @override
  String get brand;
  @override
  String get variant;
  @override
  double get pricePerPack;
  @override
  int get cigarettesPerPack;
  @override
  int get cigarettesPerDay;
  @override
  int get yearsSmoking;
  @override
  Map<String, dynamic> get profileHistory;

  /// Create a copy of SmokingProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmokingProfileImplCopyWith<_$SmokingProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SavingsTarget _$SavingsTargetFromJson(Map<String, dynamic> json) {
  return _SavingsTarget.fromJson(json);
}

/// @nodoc
mixin _$SavingsTarget {
  String get itemName => throw _privateConstructorUsedError;
  double get targetPrice => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this SavingsTarget to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavingsTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavingsTargetCopyWith<SavingsTarget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavingsTargetCopyWith<$Res> {
  factory $SavingsTargetCopyWith(
          SavingsTarget value, $Res Function(SavingsTarget) then) =
      _$SavingsTargetCopyWithImpl<$Res, SavingsTarget>;
  @useResult
  $Res call({String itemName, double targetPrice, String? imageUrl});
}

/// @nodoc
class _$SavingsTargetCopyWithImpl<$Res, $Val extends SavingsTarget>
    implements $SavingsTargetCopyWith<$Res> {
  _$SavingsTargetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavingsTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemName = null,
    Object? targetPrice = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      targetPrice: null == targetPrice
          ? _value.targetPrice
          : targetPrice // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavingsTargetImplCopyWith<$Res>
    implements $SavingsTargetCopyWith<$Res> {
  factory _$$SavingsTargetImplCopyWith(
          _$SavingsTargetImpl value, $Res Function(_$SavingsTargetImpl) then) =
      __$$SavingsTargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String itemName, double targetPrice, String? imageUrl});
}

/// @nodoc
class __$$SavingsTargetImplCopyWithImpl<$Res>
    extends _$SavingsTargetCopyWithImpl<$Res, _$SavingsTargetImpl>
    implements _$$SavingsTargetImplCopyWith<$Res> {
  __$$SavingsTargetImplCopyWithImpl(
      _$SavingsTargetImpl _value, $Res Function(_$SavingsTargetImpl) _then)
      : super(_value, _then);

  /// Create a copy of SavingsTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemName = null,
    Object? targetPrice = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$SavingsTargetImpl(
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      targetPrice: null == targetPrice
          ? _value.targetPrice
          : targetPrice // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SavingsTargetImpl implements _SavingsTarget {
  const _$SavingsTargetImpl(
      {this.itemName = '', this.targetPrice = 0, this.imageUrl});

  factory _$SavingsTargetImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavingsTargetImplFromJson(json);

  @override
  @JsonKey()
  final String itemName;
  @override
  @JsonKey()
  final double targetPrice;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'SavingsTarget(itemName: $itemName, targetPrice: $targetPrice, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavingsTargetImpl &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.targetPrice, targetPrice) ||
                other.targetPrice == targetPrice) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, itemName, targetPrice, imageUrl);

  /// Create a copy of SavingsTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavingsTargetImplCopyWith<_$SavingsTargetImpl> get copyWith =>
      __$$SavingsTargetImplCopyWithImpl<_$SavingsTargetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavingsTargetImplToJson(
      this,
    );
  }
}

abstract class _SavingsTarget implements SavingsTarget {
  const factory _SavingsTarget(
      {final String itemName,
      final double targetPrice,
      final String? imageUrl}) = _$SavingsTargetImpl;

  factory _SavingsTarget.fromJson(Map<String, dynamic> json) =
      _$SavingsTargetImpl.fromJson;

  @override
  String get itemName;
  @override
  double get targetPrice;
  @override
  String? get imageUrl;

  /// Create a copy of SavingsTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavingsTargetImplCopyWith<_$SavingsTargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressSummary _$ProgressSummaryFromJson(Map<String, dynamic> json) {
  return _ProgressSummary.fromJson(json);
}

/// @nodoc
mixin _$ProgressSummary {
  int get currentStreak => throw _privateConstructorUsedError;
  int get longestStreak => throw _privateConstructorUsedError;
  double get totalMoneySaved => throw _privateConstructorUsedError;
  int get cigarettesAvoided => throw _privateConstructorUsedError;
  int get totalDaysSmokeFree => throw _privateConstructorUsedError;
  int get relapseCount => throw _privateConstructorUsedError;
  int get totalSlips => throw _privateConstructorUsedError;
  int get todaySlips => throw _privateConstructorUsedError;
  Map<String, dynamic> get slipHistory => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastSlipDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastCheckInDate => throw _privateConstructorUsedError;

  /// Serializes this ProgressSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgressSummaryCopyWith<ProgressSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressSummaryCopyWith<$Res> {
  factory $ProgressSummaryCopyWith(
          ProgressSummary value, $Res Function(ProgressSummary) then) =
      _$ProgressSummaryCopyWithImpl<$Res, ProgressSummary>;
  @useResult
  $Res call(
      {int currentStreak,
      int longestStreak,
      double totalMoneySaved,
      int cigarettesAvoided,
      int totalDaysSmokeFree,
      int relapseCount,
      int totalSlips,
      int todaySlips,
      Map<String, dynamic> slipHistory,
      @TimestampConverter() DateTime? lastSlipDate,
      @TimestampConverter() DateTime? lastCheckInDate});
}

/// @nodoc
class _$ProgressSummaryCopyWithImpl<$Res, $Val extends ProgressSummary>
    implements $ProgressSummaryCopyWith<$Res> {
  _$ProgressSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalMoneySaved = null,
    Object? cigarettesAvoided = null,
    Object? totalDaysSmokeFree = null,
    Object? relapseCount = null,
    Object? totalSlips = null,
    Object? todaySlips = null,
    Object? slipHistory = null,
    Object? lastSlipDate = freezed,
    Object? lastCheckInDate = freezed,
  }) {
    return _then(_value.copyWith(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalMoneySaved: null == totalMoneySaved
          ? _value.totalMoneySaved
          : totalMoneySaved // ignore: cast_nullable_to_non_nullable
              as double,
      cigarettesAvoided: null == cigarettesAvoided
          ? _value.cigarettesAvoided
          : cigarettesAvoided // ignore: cast_nullable_to_non_nullable
              as int,
      totalDaysSmokeFree: null == totalDaysSmokeFree
          ? _value.totalDaysSmokeFree
          : totalDaysSmokeFree // ignore: cast_nullable_to_non_nullable
              as int,
      relapseCount: null == relapseCount
          ? _value.relapseCount
          : relapseCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSlips: null == totalSlips
          ? _value.totalSlips
          : totalSlips // ignore: cast_nullable_to_non_nullable
              as int,
      todaySlips: null == todaySlips
          ? _value.todaySlips
          : todaySlips // ignore: cast_nullable_to_non_nullable
              as int,
      slipHistory: null == slipHistory
          ? _value.slipHistory
          : slipHistory // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastSlipDate: freezed == lastSlipDate
          ? _value.lastSlipDate
          : lastSlipDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastCheckInDate: freezed == lastCheckInDate
          ? _value.lastCheckInDate
          : lastCheckInDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressSummaryImplCopyWith<$Res>
    implements $ProgressSummaryCopyWith<$Res> {
  factory _$$ProgressSummaryImplCopyWith(_$ProgressSummaryImpl value,
          $Res Function(_$ProgressSummaryImpl) then) =
      __$$ProgressSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentStreak,
      int longestStreak,
      double totalMoneySaved,
      int cigarettesAvoided,
      int totalDaysSmokeFree,
      int relapseCount,
      int totalSlips,
      int todaySlips,
      Map<String, dynamic> slipHistory,
      @TimestampConverter() DateTime? lastSlipDate,
      @TimestampConverter() DateTime? lastCheckInDate});
}

/// @nodoc
class __$$ProgressSummaryImplCopyWithImpl<$Res>
    extends _$ProgressSummaryCopyWithImpl<$Res, _$ProgressSummaryImpl>
    implements _$$ProgressSummaryImplCopyWith<$Res> {
  __$$ProgressSummaryImplCopyWithImpl(
      _$ProgressSummaryImpl _value, $Res Function(_$ProgressSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? longestStreak = null,
    Object? totalMoneySaved = null,
    Object? cigarettesAvoided = null,
    Object? totalDaysSmokeFree = null,
    Object? relapseCount = null,
    Object? totalSlips = null,
    Object? todaySlips = null,
    Object? slipHistory = null,
    Object? lastSlipDate = freezed,
    Object? lastCheckInDate = freezed,
  }) {
    return _then(_$ProgressSummaryImpl(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      longestStreak: null == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      totalMoneySaved: null == totalMoneySaved
          ? _value.totalMoneySaved
          : totalMoneySaved // ignore: cast_nullable_to_non_nullable
              as double,
      cigarettesAvoided: null == cigarettesAvoided
          ? _value.cigarettesAvoided
          : cigarettesAvoided // ignore: cast_nullable_to_non_nullable
              as int,
      totalDaysSmokeFree: null == totalDaysSmokeFree
          ? _value.totalDaysSmokeFree
          : totalDaysSmokeFree // ignore: cast_nullable_to_non_nullable
              as int,
      relapseCount: null == relapseCount
          ? _value.relapseCount
          : relapseCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalSlips: null == totalSlips
          ? _value.totalSlips
          : totalSlips // ignore: cast_nullable_to_non_nullable
              as int,
      todaySlips: null == todaySlips
          ? _value.todaySlips
          : todaySlips // ignore: cast_nullable_to_non_nullable
              as int,
      slipHistory: null == slipHistory
          ? _value._slipHistory
          : slipHistory // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastSlipDate: freezed == lastSlipDate
          ? _value.lastSlipDate
          : lastSlipDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastCheckInDate: freezed == lastCheckInDate
          ? _value.lastCheckInDate
          : lastCheckInDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressSummaryImpl implements _ProgressSummary {
  const _$ProgressSummaryImpl(
      {this.currentStreak = 0,
      this.longestStreak = 0,
      this.totalMoneySaved = 0,
      this.cigarettesAvoided = 0,
      this.totalDaysSmokeFree = 0,
      this.relapseCount = 0,
      this.totalSlips = 0,
      this.todaySlips = 0,
      final Map<String, dynamic> slipHistory = const <String, dynamic>{},
      @TimestampConverter() this.lastSlipDate,
      @TimestampConverter() this.lastCheckInDate})
      : _slipHistory = slipHistory;

  factory _$ProgressSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressSummaryImplFromJson(json);

  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int longestStreak;
  @override
  @JsonKey()
  final double totalMoneySaved;
  @override
  @JsonKey()
  final int cigarettesAvoided;
  @override
  @JsonKey()
  final int totalDaysSmokeFree;
  @override
  @JsonKey()
  final int relapseCount;
  @override
  @JsonKey()
  final int totalSlips;
  @override
  @JsonKey()
  final int todaySlips;
  final Map<String, dynamic> _slipHistory;
  @override
  @JsonKey()
  Map<String, dynamic> get slipHistory {
    if (_slipHistory is EqualUnmodifiableMapView) return _slipHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_slipHistory);
  }

  @override
  @TimestampConverter()
  final DateTime? lastSlipDate;
  @override
  @TimestampConverter()
  final DateTime? lastCheckInDate;

  @override
  String toString() {
    return 'ProgressSummary(currentStreak: $currentStreak, longestStreak: $longestStreak, totalMoneySaved: $totalMoneySaved, cigarettesAvoided: $cigarettesAvoided, totalDaysSmokeFree: $totalDaysSmokeFree, relapseCount: $relapseCount, totalSlips: $totalSlips, todaySlips: $todaySlips, slipHistory: $slipHistory, lastSlipDate: $lastSlipDate, lastCheckInDate: $lastCheckInDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressSummaryImpl &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.totalMoneySaved, totalMoneySaved) ||
                other.totalMoneySaved == totalMoneySaved) &&
            (identical(other.cigarettesAvoided, cigarettesAvoided) ||
                other.cigarettesAvoided == cigarettesAvoided) &&
            (identical(other.totalDaysSmokeFree, totalDaysSmokeFree) ||
                other.totalDaysSmokeFree == totalDaysSmokeFree) &&
            (identical(other.relapseCount, relapseCount) ||
                other.relapseCount == relapseCount) &&
            (identical(other.totalSlips, totalSlips) ||
                other.totalSlips == totalSlips) &&
            (identical(other.todaySlips, todaySlips) ||
                other.todaySlips == todaySlips) &&
            const DeepCollectionEquality()
                .equals(other._slipHistory, _slipHistory) &&
            (identical(other.lastSlipDate, lastSlipDate) ||
                other.lastSlipDate == lastSlipDate) &&
            (identical(other.lastCheckInDate, lastCheckInDate) ||
                other.lastCheckInDate == lastCheckInDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStreak,
      longestStreak,
      totalMoneySaved,
      cigarettesAvoided,
      totalDaysSmokeFree,
      relapseCount,
      totalSlips,
      todaySlips,
      const DeepCollectionEquality().hash(_slipHistory),
      lastSlipDate,
      lastCheckInDate);

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressSummaryImplCopyWith<_$ProgressSummaryImpl> get copyWith =>
      __$$ProgressSummaryImplCopyWithImpl<_$ProgressSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressSummaryImplToJson(
      this,
    );
  }
}

abstract class _ProgressSummary implements ProgressSummary {
  const factory _ProgressSummary(
          {final int currentStreak,
          final int longestStreak,
          final double totalMoneySaved,
          final int cigarettesAvoided,
          final int totalDaysSmokeFree,
          final int relapseCount,
          final int totalSlips,
          final int todaySlips,
          final Map<String, dynamic> slipHistory,
          @TimestampConverter() final DateTime? lastSlipDate,
          @TimestampConverter() final DateTime? lastCheckInDate}) =
      _$ProgressSummaryImpl;

  factory _ProgressSummary.fromJson(Map<String, dynamic> json) =
      _$ProgressSummaryImpl.fromJson;

  @override
  int get currentStreak;
  @override
  int get longestStreak;
  @override
  double get totalMoneySaved;
  @override
  int get cigarettesAvoided;
  @override
  int get totalDaysSmokeFree;
  @override
  int get relapseCount;
  @override
  int get totalSlips;
  @override
  int get todaySlips;
  @override
  Map<String, dynamic> get slipHistory;
  @override
  @TimestampConverter()
  DateTime? get lastSlipDate;
  @override
  @TimestampConverter()
  DateTime? get lastCheckInDate;

  /// Create a copy of ProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgressSummaryImplCopyWith<_$ProgressSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
