// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'festival_and_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FestivalAndTasks _$FestivalAndTasksFromJson(Map<String, dynamic> json) {
  return _FestivalAndTasks.fromJson(json);
}

/// @nodoc
mixin _$FestivalAndTasks {
  String get id => throw _privateConstructorUsedError; //节日名称
  String get festivalName => throw _privateConstructorUsedError; //节日名称
  DateTime get data => throw _privateConstructorUsedError; //日期
  String get imageUrl => throw _privateConstructorUsedError; //背景图片
  int get plans => throw _privateConstructorUsedError; //计划数
  FestivalFilter get dayType =>
      throw _privateConstructorUsedError; //日期类型 ：阳历 阴历 国家法定 自定义
  int get countDown => throw _privateConstructorUsedError; //倒计时多少天
  String get state => throw _privateConstructorUsedError; //状态
  String get festivalDescription => throw _privateConstructorUsedError; // 节日描述
  List<TaskItem> get taskItem => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FestivalAndTasksCopyWith<FestivalAndTasks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FestivalAndTasksCopyWith<$Res> {
  factory $FestivalAndTasksCopyWith(
          FestivalAndTasks value, $Res Function(FestivalAndTasks) then) =
      _$FestivalAndTasksCopyWithImpl<$Res, FestivalAndTasks>;
  @useResult
  $Res call(
      {String id,
      String festivalName,
      DateTime data,
      String imageUrl,
      int plans,
      FestivalFilter dayType,
      int countDown,
      String state,
      String festivalDescription,
      List<TaskItem> taskItem});
}

/// @nodoc
class _$FestivalAndTasksCopyWithImpl<$Res, $Val extends FestivalAndTasks>
    implements $FestivalAndTasksCopyWith<$Res> {
  _$FestivalAndTasksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? festivalName = null,
    Object? data = null,
    Object? imageUrl = null,
    Object? plans = null,
    Object? dayType = null,
    Object? countDown = null,
    Object? state = null,
    Object? festivalDescription = null,
    Object? taskItem = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      festivalName: null == festivalName
          ? _value.festivalName
          : festivalName // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      plans: null == plans
          ? _value.plans
          : plans // ignore: cast_nullable_to_non_nullable
              as int,
      dayType: null == dayType
          ? _value.dayType
          : dayType // ignore: cast_nullable_to_non_nullable
              as FestivalFilter,
      countDown: null == countDown
          ? _value.countDown
          : countDown // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      festivalDescription: null == festivalDescription
          ? _value.festivalDescription
          : festivalDescription // ignore: cast_nullable_to_non_nullable
              as String,
      taskItem: null == taskItem
          ? _value.taskItem
          : taskItem // ignore: cast_nullable_to_non_nullable
              as List<TaskItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FestivalAndTasksImplCopyWith<$Res>
    implements $FestivalAndTasksCopyWith<$Res> {
  factory _$$FestivalAndTasksImplCopyWith(_$FestivalAndTasksImpl value,
          $Res Function(_$FestivalAndTasksImpl) then) =
      __$$FestivalAndTasksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String festivalName,
      DateTime data,
      String imageUrl,
      int plans,
      FestivalFilter dayType,
      int countDown,
      String state,
      String festivalDescription,
      List<TaskItem> taskItem});
}

/// @nodoc
class __$$FestivalAndTasksImplCopyWithImpl<$Res>
    extends _$FestivalAndTasksCopyWithImpl<$Res, _$FestivalAndTasksImpl>
    implements _$$FestivalAndTasksImplCopyWith<$Res> {
  __$$FestivalAndTasksImplCopyWithImpl(_$FestivalAndTasksImpl _value,
      $Res Function(_$FestivalAndTasksImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? festivalName = null,
    Object? data = null,
    Object? imageUrl = null,
    Object? plans = null,
    Object? dayType = null,
    Object? countDown = null,
    Object? state = null,
    Object? festivalDescription = null,
    Object? taskItem = null,
  }) {
    return _then(_$FestivalAndTasksImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      festivalName: null == festivalName
          ? _value.festivalName
          : festivalName // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      plans: null == plans
          ? _value.plans
          : plans // ignore: cast_nullable_to_non_nullable
              as int,
      dayType: null == dayType
          ? _value.dayType
          : dayType // ignore: cast_nullable_to_non_nullable
              as FestivalFilter,
      countDown: null == countDown
          ? _value.countDown
          : countDown // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      festivalDescription: null == festivalDescription
          ? _value.festivalDescription
          : festivalDescription // ignore: cast_nullable_to_non_nullable
              as String,
      taskItem: null == taskItem
          ? _value._taskItem
          : taskItem // ignore: cast_nullable_to_non_nullable
              as List<TaskItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FestivalAndTasksImpl implements _FestivalAndTasks {
  const _$FestivalAndTasksImpl(
      {required this.id,
      required this.festivalName,
      required this.data,
      required this.imageUrl,
      required this.plans,
      required this.dayType,
      required this.countDown,
      required this.state,
      required this.festivalDescription,
      required final List<TaskItem> taskItem})
      : _taskItem = taskItem;

  factory _$FestivalAndTasksImpl.fromJson(Map<String, dynamic> json) =>
      _$$FestivalAndTasksImplFromJson(json);

  @override
  final String id;
//节日名称
  @override
  final String festivalName;
//节日名称
  @override
  final DateTime data;
//日期
  @override
  final String imageUrl;
//背景图片
  @override
  final int plans;
//计划数
  @override
  final FestivalFilter dayType;
//日期类型 ：阳历 阴历 国家法定 自定义
  @override
  final int countDown;
//倒计时多少天
  @override
  final String state;
//状态
  @override
  final String festivalDescription;
// 节日描述
  final List<TaskItem> _taskItem;
// 节日描述
  @override
  List<TaskItem> get taskItem {
    if (_taskItem is EqualUnmodifiableListView) return _taskItem;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taskItem);
  }

  @override
  String toString() {
    return 'FestivalAndTasks(id: $id, festivalName: $festivalName, data: $data, imageUrl: $imageUrl, plans: $plans, dayType: $dayType, countDown: $countDown, state: $state, festivalDescription: $festivalDescription, taskItem: $taskItem)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FestivalAndTasksImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.festivalName, festivalName) ||
                other.festivalName == festivalName) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.plans, plans) || other.plans == plans) &&
            (identical(other.dayType, dayType) || other.dayType == dayType) &&
            (identical(other.countDown, countDown) ||
                other.countDown == countDown) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.festivalDescription, festivalDescription) ||
                other.festivalDescription == festivalDescription) &&
            const DeepCollectionEquality().equals(other._taskItem, _taskItem));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      festivalName,
      data,
      imageUrl,
      plans,
      dayType,
      countDown,
      state,
      festivalDescription,
      const DeepCollectionEquality().hash(_taskItem));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FestivalAndTasksImplCopyWith<_$FestivalAndTasksImpl> get copyWith =>
      __$$FestivalAndTasksImplCopyWithImpl<_$FestivalAndTasksImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FestivalAndTasksImplToJson(
      this,
    );
  }
}

abstract class _FestivalAndTasks implements FestivalAndTasks {
  const factory _FestivalAndTasks(
      {required final String id,
      required final String festivalName,
      required final DateTime data,
      required final String imageUrl,
      required final int plans,
      required final FestivalFilter dayType,
      required final int countDown,
      required final String state,
      required final String festivalDescription,
      required final List<TaskItem> taskItem}) = _$FestivalAndTasksImpl;

  factory _FestivalAndTasks.fromJson(Map<String, dynamic> json) =
      _$FestivalAndTasksImpl.fromJson;

  @override
  String get id;
  @override //节日名称
  String get festivalName;
  @override //节日名称
  DateTime get data;
  @override //日期
  String get imageUrl;
  @override //背景图片
  int get plans;
  @override //计划数
  FestivalFilter get dayType;
  @override //日期类型 ：阳历 阴历 国家法定 自定义
  int get countDown;
  @override //倒计时多少天
  String get state;
  @override //状态
  String get festivalDescription;
  @override // 节日描述
  List<TaskItem> get taskItem;
  @override
  @JsonKey(ignore: true)
  _$$FestivalAndTasksImplCopyWith<_$FestivalAndTasksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskItem _$TaskItemFromJson(Map<String, dynamic> json) {
  return _TaskItem.fromJson(json);
}

/// @nodoc
mixin _$TaskItem {
  String get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isEditing => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskItemCopyWith<TaskItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskItemCopyWith<$Res> {
  factory $TaskItemCopyWith(TaskItem value, $Res Function(TaskItem) then) =
      _$TaskItemCopyWithImpl<$Res, TaskItem>;
  @useResult
  $Res call({String id, String content, bool isCompleted, bool isEditing});
}

/// @nodoc
class _$TaskItemCopyWithImpl<$Res, $Val extends TaskItem>
    implements $TaskItemCopyWith<$Res> {
  _$TaskItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isCompleted = null,
    Object? isEditing = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskItemImplCopyWith<$Res>
    implements $TaskItemCopyWith<$Res> {
  factory _$$TaskItemImplCopyWith(
          _$TaskItemImpl value, $Res Function(_$TaskItemImpl) then) =
      __$$TaskItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String content, bool isCompleted, bool isEditing});
}

/// @nodoc
class __$$TaskItemImplCopyWithImpl<$Res>
    extends _$TaskItemCopyWithImpl<$Res, _$TaskItemImpl>
    implements _$$TaskItemImplCopyWith<$Res> {
  __$$TaskItemImplCopyWithImpl(
      _$TaskItemImpl _value, $Res Function(_$TaskItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? isCompleted = null,
    Object? isEditing = null,
  }) {
    return _then(_$TaskItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskItemImpl implements _TaskItem {
  const _$TaskItemImpl(
      {required this.id,
      required this.content,
      this.isCompleted = false,
      this.isEditing = false});

  factory _$TaskItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskItemImplFromJson(json);

  @override
  final String id;
  @override
  final String content;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool isEditing;

  @override
  String toString() {
    return 'TaskItem(id: $id, content: $content, isCompleted: $isCompleted, isEditing: $isEditing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, content, isCompleted, isEditing);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskItemImplCopyWith<_$TaskItemImpl> get copyWith =>
      __$$TaskItemImplCopyWithImpl<_$TaskItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskItemImplToJson(
      this,
    );
  }
}

abstract class _TaskItem implements TaskItem {
  const factory _TaskItem(
      {required final String id,
      required final String content,
      final bool isCompleted,
      final bool isEditing}) = _$TaskItemImpl;

  factory _TaskItem.fromJson(Map<String, dynamic> json) =
      _$TaskItemImpl.fromJson;

  @override
  String get id;
  @override
  String get content;
  @override
  bool get isCompleted;
  @override
  bool get isEditing;
  @override
  @JsonKey(ignore: true)
  _$$TaskItemImplCopyWith<_$TaskItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
