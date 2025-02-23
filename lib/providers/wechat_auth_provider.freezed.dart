// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wechat_auth_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WechatAuthState {
  LoginStatus get status => throw _privateConstructorUsedError;
  AuthErrorType? get errorType => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  WeChatAuthResponse? get authResponse => throw _privateConstructorUsedError;
  bool get isAuthenticated => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get nickname => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WechatAuthStateCopyWith<WechatAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WechatAuthStateCopyWith<$Res> {
  factory $WechatAuthStateCopyWith(
          WechatAuthState value, $Res Function(WechatAuthState) then) =
      _$WechatAuthStateCopyWithImpl<$Res, WechatAuthState>;
  @useResult
  $Res call(
      {LoginStatus status,
      AuthErrorType? errorType,
      String? errorMessage,
      WeChatAuthResponse? authResponse,
      bool isAuthenticated,
      String? code,
      String? nickname,
      String? avatarUrl});
}

/// @nodoc
class _$WechatAuthStateCopyWithImpl<$Res, $Val extends WechatAuthState>
    implements $WechatAuthStateCopyWith<$Res> {
  _$WechatAuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorType = freezed,
    Object? errorMessage = freezed,
    Object? authResponse = freezed,
    Object? isAuthenticated = null,
    Object? code = freezed,
    Object? nickname = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoginStatus,
      errorType: freezed == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AuthErrorType?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      authResponse: freezed == authResponse
          ? _value.authResponse
          : authResponse // ignore: cast_nullable_to_non_nullable
              as WeChatAuthResponse?,
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WechatAuthStateImplCopyWith<$Res>
    implements $WechatAuthStateCopyWith<$Res> {
  factory _$$WechatAuthStateImplCopyWith(_$WechatAuthStateImpl value,
          $Res Function(_$WechatAuthStateImpl) then) =
      __$$WechatAuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoginStatus status,
      AuthErrorType? errorType,
      String? errorMessage,
      WeChatAuthResponse? authResponse,
      bool isAuthenticated,
      String? code,
      String? nickname,
      String? avatarUrl});
}

/// @nodoc
class __$$WechatAuthStateImplCopyWithImpl<$Res>
    extends _$WechatAuthStateCopyWithImpl<$Res, _$WechatAuthStateImpl>
    implements _$$WechatAuthStateImplCopyWith<$Res> {
  __$$WechatAuthStateImplCopyWithImpl(
      _$WechatAuthStateImpl _value, $Res Function(_$WechatAuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? errorType = freezed,
    Object? errorMessage = freezed,
    Object? authResponse = freezed,
    Object? isAuthenticated = null,
    Object? code = freezed,
    Object? nickname = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(_$WechatAuthStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoginStatus,
      errorType: freezed == errorType
          ? _value.errorType
          : errorType // ignore: cast_nullable_to_non_nullable
              as AuthErrorType?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      authResponse: freezed == authResponse
          ? _value.authResponse
          : authResponse // ignore: cast_nullable_to_non_nullable
              as WeChatAuthResponse?,
      isAuthenticated: null == isAuthenticated
          ? _value.isAuthenticated
          : isAuthenticated // ignore: cast_nullable_to_non_nullable
              as bool,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WechatAuthStateImpl
    with DiagnosticableTreeMixin
    implements _WechatAuthState {
  const _$WechatAuthStateImpl(
      {this.status = LoginStatus.initial,
      this.errorType = null,
      this.errorMessage = null,
      this.authResponse = null,
      this.isAuthenticated = false,
      this.code,
      this.nickname,
      this.avatarUrl});

  @override
  @JsonKey()
  final LoginStatus status;
  @override
  @JsonKey()
  final AuthErrorType? errorType;
  @override
  @JsonKey()
  final String? errorMessage;
  @override
  @JsonKey()
  final WeChatAuthResponse? authResponse;
  @override
  @JsonKey()
  final bool isAuthenticated;
  @override
  final String? code;
  @override
  final String? nickname;
  @override
  final String? avatarUrl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WechatAuthState(status: $status, errorType: $errorType, errorMessage: $errorMessage, authResponse: $authResponse, isAuthenticated: $isAuthenticated, code: $code, nickname: $nickname, avatarUrl: $avatarUrl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WechatAuthState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('errorType', errorType))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('authResponse', authResponse))
      ..add(DiagnosticsProperty('isAuthenticated', isAuthenticated))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('nickname', nickname))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WechatAuthStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.authResponse, authResponse) ||
                other.authResponse == authResponse) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, errorType, errorMessage,
      authResponse, isAuthenticated, code, nickname, avatarUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WechatAuthStateImplCopyWith<_$WechatAuthStateImpl> get copyWith =>
      __$$WechatAuthStateImplCopyWithImpl<_$WechatAuthStateImpl>(
          this, _$identity);
}

abstract class _WechatAuthState implements WechatAuthState {
  const factory _WechatAuthState(
      {final LoginStatus status,
      final AuthErrorType? errorType,
      final String? errorMessage,
      final WeChatAuthResponse? authResponse,
      final bool isAuthenticated,
      final String? code,
      final String? nickname,
      final String? avatarUrl}) = _$WechatAuthStateImpl;

  @override
  LoginStatus get status;
  @override
  AuthErrorType? get errorType;
  @override
  String? get errorMessage;
  @override
  WeChatAuthResponse? get authResponse;
  @override
  bool get isAuthenticated;
  @override
  String? get code;
  @override
  String? get nickname;
  @override
  String? get avatarUrl;
  @override
  @JsonKey(ignore: true)
  _$$WechatAuthStateImplCopyWith<_$WechatAuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
