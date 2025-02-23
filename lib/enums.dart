import 'package:freezed_annotation/freezed_annotation.dart';

enum LoginType {
  @JsonValue(0)
  wechat,
  @JsonValue(1)
  qq,
  @JsonValue(2)
  phone,
}

enum LoginStatus {
  @JsonValue(0)
  initial,
  @JsonValue(1)
  inProgress,
  @JsonValue(2)
  success,
  @JsonValue(3)
  failure,
}

enum AuthErrorType {
  @JsonValue(0)
  networkError,
  @JsonValue(1)
  cancelled,
  @JsonValue(2)
  notInstalled,
  @JsonValue(3)
  unknown,
}

enum FestivalState { completed, ongoing, notStarted }
