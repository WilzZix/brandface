// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegistrationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationEvent()';
}


}

/// @nodoc
class $RegistrationEventCopyWith<$Res>  {
$RegistrationEventCopyWith(RegistrationEvent _, $Res Function(RegistrationEvent) __);
}


/// Adds pattern-matching-related methods to [RegistrationEvent].
extension RegistrationEventPatterns on RegistrationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _Registration value)?  registration,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Registration() when registration != null:
return registration(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _Registration value)  registration,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _Registration():
return registration(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _Registration value)?  registration,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Registration() when registration != null:
return registration(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( RegistrationParams params)?  registration,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Registration() when registration != null:
return registration(_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( RegistrationParams params)  registration,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _Registration():
return registration(_that.params);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( RegistrationParams params)?  registration,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Registration() when registration != null:
return registration(_that.params);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements RegistrationEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationEvent.started()';
}


}




/// @nodoc


class _Registration implements RegistrationEvent {
  const _Registration({required this.params});
  

 final  RegistrationParams params;

/// Create a copy of RegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegistrationCopyWith<_Registration> get copyWith => __$RegistrationCopyWithImpl<_Registration>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Registration&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'RegistrationEvent.registration(params: $params)';
}


}

/// @nodoc
abstract mixin class _$RegistrationCopyWith<$Res> implements $RegistrationEventCopyWith<$Res> {
  factory _$RegistrationCopyWith(_Registration value, $Res Function(_Registration) _then) = __$RegistrationCopyWithImpl;
@useResult
$Res call({
 RegistrationParams params
});




}
/// @nodoc
class __$RegistrationCopyWithImpl<$Res>
    implements _$RegistrationCopyWith<$Res> {
  __$RegistrationCopyWithImpl(this._self, this._then);

  final _Registration _self;
  final $Res Function(_Registration) _then;

/// Create a copy of RegistrationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(_Registration(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as RegistrationParams,
  ));
}


}

/// @nodoc
mixin _$RegistrationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegistrationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState()';
}


}

/// @nodoc
class $RegistrationStateCopyWith<$Res>  {
$RegistrationStateCopyWith(RegistrationState _, $Res Function(RegistrationState) __);
}


/// Adds pattern-matching-related methods to [RegistrationState].
extension RegistrationStatePatterns on RegistrationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _UserRegistered value)?  userRegistered,TResult Function( _UserRegistering value)?  userRegistering,TResult Function( _UserRegisterFailure value)?  userRegisterFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _UserRegistered() when userRegistered != null:
return userRegistered(_that);case _UserRegistering() when userRegistering != null:
return userRegistering(_that);case _UserRegisterFailure() when userRegisterFailure != null:
return userRegisterFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _UserRegistered value)  userRegistered,required TResult Function( _UserRegistering value)  userRegistering,required TResult Function( _UserRegisterFailure value)  userRegisterFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _UserRegistered():
return userRegistered(_that);case _UserRegistering():
return userRegistering(_that);case _UserRegisterFailure():
return userRegisterFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _UserRegistered value)?  userRegistered,TResult? Function( _UserRegistering value)?  userRegistering,TResult? Function( _UserRegisterFailure value)?  userRegisterFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _UserRegistered() when userRegistered != null:
return userRegistered(_that);case _UserRegistering() when userRegistering != null:
return userRegistering(_that);case _UserRegisterFailure() when userRegisterFailure != null:
return userRegisterFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( RegistrationEntity registerEntity)?  userRegistered,TResult Function()?  userRegistering,TResult Function( String msg)?  userRegisterFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _UserRegistered() when userRegistered != null:
return userRegistered(_that.registerEntity);case _UserRegistering() when userRegistering != null:
return userRegistering();case _UserRegisterFailure() when userRegisterFailure != null:
return userRegisterFailure(_that.msg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( RegistrationEntity registerEntity)  userRegistered,required TResult Function()  userRegistering,required TResult Function( String msg)  userRegisterFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _UserRegistered():
return userRegistered(_that.registerEntity);case _UserRegistering():
return userRegistering();case _UserRegisterFailure():
return userRegisterFailure(_that.msg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( RegistrationEntity registerEntity)?  userRegistered,TResult? Function()?  userRegistering,TResult? Function( String msg)?  userRegisterFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _UserRegistered() when userRegistered != null:
return userRegistered(_that.registerEntity);case _UserRegistering() when userRegistering != null:
return userRegistering();case _UserRegisterFailure() when userRegisterFailure != null:
return userRegisterFailure(_that.msg);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements RegistrationState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState.initial()';
}


}




/// @nodoc


class _UserRegistered implements RegistrationState {
  const _UserRegistered({required this.registerEntity});
  

 final  RegistrationEntity registerEntity;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRegisteredCopyWith<_UserRegistered> get copyWith => __$UserRegisteredCopyWithImpl<_UserRegistered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRegistered&&(identical(other.registerEntity, registerEntity) || other.registerEntity == registerEntity));
}


@override
int get hashCode => Object.hash(runtimeType,registerEntity);

@override
String toString() {
  return 'RegistrationState.userRegistered(registerEntity: $registerEntity)';
}


}

/// @nodoc
abstract mixin class _$UserRegisteredCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
  factory _$UserRegisteredCopyWith(_UserRegistered value, $Res Function(_UserRegistered) _then) = __$UserRegisteredCopyWithImpl;
@useResult
$Res call({
 RegistrationEntity registerEntity
});




}
/// @nodoc
class __$UserRegisteredCopyWithImpl<$Res>
    implements _$UserRegisteredCopyWith<$Res> {
  __$UserRegisteredCopyWithImpl(this._self, this._then);

  final _UserRegistered _self;
  final $Res Function(_UserRegistered) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? registerEntity = null,}) {
  return _then(_UserRegistered(
registerEntity: null == registerEntity ? _self.registerEntity : registerEntity // ignore: cast_nullable_to_non_nullable
as RegistrationEntity,
  ));
}


}

/// @nodoc


class _UserRegistering implements RegistrationState {
  const _UserRegistering();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRegistering);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegistrationState.userRegistering()';
}


}




/// @nodoc


class _UserRegisterFailure implements RegistrationState {
  const _UserRegisterFailure({required this.msg});
  

 final  String msg;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRegisterFailureCopyWith<_UserRegisterFailure> get copyWith => __$UserRegisterFailureCopyWithImpl<_UserRegisterFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRegisterFailure&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,msg);

@override
String toString() {
  return 'RegistrationState.userRegisterFailure(msg: $msg)';
}


}

/// @nodoc
abstract mixin class _$UserRegisterFailureCopyWith<$Res> implements $RegistrationStateCopyWith<$Res> {
  factory _$UserRegisterFailureCopyWith(_UserRegisterFailure value, $Res Function(_UserRegisterFailure) _then) = __$UserRegisterFailureCopyWithImpl;
@useResult
$Res call({
 String msg
});




}
/// @nodoc
class __$UserRegisterFailureCopyWithImpl<$Res>
    implements _$UserRegisterFailureCopyWith<$Res> {
  __$UserRegisterFailureCopyWithImpl(this._self, this._then);

  final _UserRegisterFailure _self;
  final $Res Function(_UserRegisterFailure) _then;

/// Create a copy of RegistrationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? msg = null,}) {
  return _then(_UserRegisterFailure(
msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
