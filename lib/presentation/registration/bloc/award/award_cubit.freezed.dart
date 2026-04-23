// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'award_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AwardState {

 List<AwardEntity> get awards;
/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AwardStateCopyWith<AwardState> get copyWith => _$AwardStateCopyWithImpl<AwardState>(this as AwardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AwardState&&const DeepCollectionEquality().equals(other.awards, awards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(awards));

@override
String toString() {
  return 'AwardState(awards: $awards)';
}


}

/// @nodoc
abstract mixin class $AwardStateCopyWith<$Res>  {
  factory $AwardStateCopyWith(AwardState value, $Res Function(AwardState) _then) = _$AwardStateCopyWithImpl;
@useResult
$Res call({
 List<AwardEntity> awards
});




}
/// @nodoc
class _$AwardStateCopyWithImpl<$Res>
    implements $AwardStateCopyWith<$Res> {
  _$AwardStateCopyWithImpl(this._self, this._then);

  final AwardState _self;
  final $Res Function(AwardState) _then;

/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? awards = null,}) {
  return _then(_self.copyWith(
awards: null == awards ? _self.awards : awards // ignore: cast_nullable_to_non_nullable
as List<AwardEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [AwardState].
extension AwardStatePatterns on AwardState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Failure():
return failure(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Failure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<AwardEntity> awards)?  initial,TResult Function( List<AwardEntity> awards)?  loading,TResult Function( List<AwardEntity> awards)?  success,TResult Function( List<AwardEntity> awards,  Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.awards);case _Loading() when loading != null:
return loading(_that.awards);case _Success() when success != null:
return success(_that.awards);case _Failure() when failure != null:
return failure(_that.awards,_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<AwardEntity> awards)  initial,required TResult Function( List<AwardEntity> awards)  loading,required TResult Function( List<AwardEntity> awards)  success,required TResult Function( List<AwardEntity> awards,  Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial(_that.awards);case _Loading():
return loading(_that.awards);case _Success():
return success(_that.awards);case _Failure():
return failure(_that.awards,_that.failure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<AwardEntity> awards)?  initial,TResult? Function( List<AwardEntity> awards)?  loading,TResult? Function( List<AwardEntity> awards)?  success,TResult? Function( List<AwardEntity> awards,  Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that.awards);case _Loading() when loading != null:
return loading(_that.awards);case _Success() when success != null:
return success(_that.awards);case _Failure() when failure != null:
return failure(_that.awards,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements AwardState {
  const _Initial({final  List<AwardEntity> awards = const []}): _awards = awards;
  

 final  List<AwardEntity> _awards;
@override@JsonKey() List<AwardEntity> get awards {
  if (_awards is EqualUnmodifiableListView) return _awards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_awards);
}


/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialCopyWith<_Initial> get copyWith => __$InitialCopyWithImpl<_Initial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial&&const DeepCollectionEquality().equals(other._awards, _awards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_awards));

@override
String toString() {
  return 'AwardState.initial(awards: $awards)';
}


}

/// @nodoc
abstract mixin class _$InitialCopyWith<$Res> implements $AwardStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) _then) = __$InitialCopyWithImpl;
@override @useResult
$Res call({
 List<AwardEntity> awards
});




}
/// @nodoc
class __$InitialCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(this._self, this._then);

  final _Initial _self;
  final $Res Function(_Initial) _then;

/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? awards = null,}) {
  return _then(_Initial(
awards: null == awards ? _self._awards : awards // ignore: cast_nullable_to_non_nullable
as List<AwardEntity>,
  ));
}


}

/// @nodoc


class _Loading implements AwardState {
  const _Loading({final  List<AwardEntity> awards = const []}): _awards = awards;
  

 final  List<AwardEntity> _awards;
@override@JsonKey() List<AwardEntity> get awards {
  if (_awards is EqualUnmodifiableListView) return _awards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_awards);
}


/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadingCopyWith<_Loading> get copyWith => __$LoadingCopyWithImpl<_Loading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading&&const DeepCollectionEquality().equals(other._awards, _awards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_awards));

@override
String toString() {
  return 'AwardState.loading(awards: $awards)';
}


}

/// @nodoc
abstract mixin class _$LoadingCopyWith<$Res> implements $AwardStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) _then) = __$LoadingCopyWithImpl;
@override @useResult
$Res call({
 List<AwardEntity> awards
});




}
/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(this._self, this._then);

  final _Loading _self;
  final $Res Function(_Loading) _then;

/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? awards = null,}) {
  return _then(_Loading(
awards: null == awards ? _self._awards : awards // ignore: cast_nullable_to_non_nullable
as List<AwardEntity>,
  ));
}


}

/// @nodoc


class _Success implements AwardState {
  const _Success({required final  List<AwardEntity> awards}): _awards = awards;
  

 final  List<AwardEntity> _awards;
@override List<AwardEntity> get awards {
  if (_awards is EqualUnmodifiableListView) return _awards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_awards);
}


/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other._awards, _awards));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_awards));

@override
String toString() {
  return 'AwardState.success(awards: $awards)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $AwardStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@override @useResult
$Res call({
 List<AwardEntity> awards
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? awards = null,}) {
  return _then(_Success(
awards: null == awards ? _self._awards : awards // ignore: cast_nullable_to_non_nullable
as List<AwardEntity>,
  ));
}


}

/// @nodoc


class _Failure implements AwardState {
  const _Failure({required final  List<AwardEntity> awards, required this.failure}): _awards = awards;
  

 final  List<AwardEntity> _awards;
@override List<AwardEntity> get awards {
  if (_awards is EqualUnmodifiableListView) return _awards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_awards);
}

 final  Failure failure;

/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&const DeepCollectionEquality().equals(other._awards, _awards)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_awards),failure);

@override
String toString() {
  return 'AwardState.failure(awards: $awards, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $AwardStateCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@override @useResult
$Res call({
 List<AwardEntity> awards, Failure failure
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of AwardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? awards = null,Object? failure = null,}) {
  return _then(_Failure(
awards: null == awards ? _self._awards : awards // ignore: cast_nullable_to_non_nullable
as List<AwardEntity>,failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
