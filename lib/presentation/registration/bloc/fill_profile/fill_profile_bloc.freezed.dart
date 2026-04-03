// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fill_profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FillProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FillProfileEvent()';
}


}

/// @nodoc
class $FillProfileEventCopyWith<$Res>  {
$FillProfileEventCopyWith(FillProfileEvent _, $Res Function(FillProfileEvent) __);
}


/// Adds pattern-matching-related methods to [FillProfileEvent].
extension FillProfileEventPatterns on FillProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FillProfile value)?  fillProfile,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FillProfile() when fillProfile != null:
return fillProfile(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FillProfile value)  fillProfile,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FillProfile():
return fillProfile(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FillProfile value)?  fillProfile,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FillProfile() when fillProfile != null:
return fillProfile(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String profile,  FillInfluencerProfileParam params)?  fillProfile,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FillProfile() when fillProfile != null:
return fillProfile(_that.profile,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String profile,  FillInfluencerProfileParam params)  fillProfile,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FillProfile():
return fillProfile(_that.profile,_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String profile,  FillInfluencerProfileParam params)?  fillProfile,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FillProfile() when fillProfile != null:
return fillProfile(_that.profile,_that.params);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements FillProfileEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FillProfileEvent.started()';
}


}




/// @nodoc


class _FillProfile implements FillProfileEvent {
  const _FillProfile({required this.profile, required this.params});
  

 final  String profile;
 final  FillInfluencerProfileParam params;

/// Create a copy of FillProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FillProfileCopyWith<_FillProfile> get copyWith => __$FillProfileCopyWithImpl<_FillProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillProfile&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,profile,params);

@override
String toString() {
  return 'FillProfileEvent.fillProfile(profile: $profile, params: $params)';
}


}

/// @nodoc
abstract mixin class _$FillProfileCopyWith<$Res> implements $FillProfileEventCopyWith<$Res> {
  factory _$FillProfileCopyWith(_FillProfile value, $Res Function(_FillProfile) _then) = __$FillProfileCopyWithImpl;
@useResult
$Res call({
 String profile, FillInfluencerProfileParam params
});




}
/// @nodoc
class __$FillProfileCopyWithImpl<$Res>
    implements _$FillProfileCopyWith<$Res> {
  __$FillProfileCopyWithImpl(this._self, this._then);

  final _FillProfile _self;
  final $Res Function(_FillProfile) _then;

/// Create a copy of FillProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? params = null,}) {
  return _then(_FillProfile(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as FillInfluencerProfileParam,
  ));
}


}

/// @nodoc
mixin _$FillProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FillProfileState()';
}


}

/// @nodoc
class $FillProfileStateCopyWith<$Res>  {
$FillProfileStateCopyWith(FillProfileState _, $Res Function(FillProfileState) __);
}


/// Adds pattern-matching-related methods to [FillProfileState].
extension FillProfileStatePatterns on FillProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _FillProfileLoading value)?  loading,TResult Function( _FillProfileFilled value)?  filled,TResult Function( _FillProfileFailure value)?  fillingFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _FillProfileLoading() when loading != null:
return loading(_that);case _FillProfileFilled() when filled != null:
return filled(_that);case _FillProfileFailure() when fillingFailure != null:
return fillingFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _FillProfileLoading value)  loading,required TResult Function( _FillProfileFilled value)  filled,required TResult Function( _FillProfileFailure value)  fillingFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _FillProfileLoading():
return loading(_that);case _FillProfileFilled():
return filled(_that);case _FillProfileFailure():
return fillingFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _FillProfileLoading value)?  loading,TResult? Function( _FillProfileFilled value)?  filled,TResult? Function( _FillProfileFailure value)?  fillingFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _FillProfileLoading() when loading != null:
return loading(_that);case _FillProfileFilled() when filled != null:
return filled(_that);case _FillProfileFailure() when fillingFailure != null:
return fillingFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  filled,TResult Function( String msg)?  fillingFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _FillProfileLoading() when loading != null:
return loading();case _FillProfileFilled() when filled != null:
return filled();case _FillProfileFailure() when fillingFailure != null:
return fillingFailure(_that.msg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  filled,required TResult Function( String msg)  fillingFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _FillProfileLoading():
return loading();case _FillProfileFilled():
return filled();case _FillProfileFailure():
return fillingFailure(_that.msg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  filled,TResult? Function( String msg)?  fillingFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _FillProfileLoading() when loading != null:
return loading();case _FillProfileFilled() when filled != null:
return filled();case _FillProfileFailure() when fillingFailure != null:
return fillingFailure(_that.msg);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements FillProfileState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FillProfileState.initial()';
}


}




/// @nodoc


class _FillProfileLoading implements FillProfileState {
  const _FillProfileLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FillProfileState.loading()';
}


}




/// @nodoc


class _FillProfileFilled implements FillProfileState {
  const _FillProfileFilled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillProfileFilled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FillProfileState.filled()';
}


}




/// @nodoc


class _FillProfileFailure implements FillProfileState {
  const _FillProfileFailure({required this.msg});
  

 final  String msg;

/// Create a copy of FillProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FillProfileFailureCopyWith<_FillProfileFailure> get copyWith => __$FillProfileFailureCopyWithImpl<_FillProfileFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillProfileFailure&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,msg);

@override
String toString() {
  return 'FillProfileState.fillingFailure(msg: $msg)';
}


}

/// @nodoc
abstract mixin class _$FillProfileFailureCopyWith<$Res> implements $FillProfileStateCopyWith<$Res> {
  factory _$FillProfileFailureCopyWith(_FillProfileFailure value, $Res Function(_FillProfileFailure) _then) = __$FillProfileFailureCopyWithImpl;
@useResult
$Res call({
 String msg
});




}
/// @nodoc
class __$FillProfileFailureCopyWithImpl<$Res>
    implements _$FillProfileFailureCopyWith<$Res> {
  __$FillProfileFailureCopyWithImpl(this._self, this._then);

  final _FillProfileFailure _self;
  final $Res Function(_FillProfileFailure) _then;

/// Create a copy of FillProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? msg = null,}) {
  return _then(_FillProfileFailure(
msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
