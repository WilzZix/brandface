// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent()';
}


}

/// @nodoc
class $LoginEventCopyWith<$Res>  {
$LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}


/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _SendOtp value)?  sendOtp,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SendOtp() when sendOtp != null:
return sendOtp(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _SendOtp value)  sendOtp,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _SendOtp():
return sendOtp(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _SendOtp value)?  sendOtp,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SendOtp() when sendOtp != null:
return sendOtp(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String phone)?  sendOtp,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SendOtp() when sendOtp != null:
return sendOtp(_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String phone)  sendOtp,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _SendOtp():
return sendOtp(_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String phone)?  sendOtp,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SendOtp() when sendOtp != null:
return sendOtp(_that.phone);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements LoginEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.started()';
}


}




/// @nodoc


class _SendOtp implements LoginEvent {
  const _SendOtp({required this.phone});
  

 final  String phone;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendOtpCopyWith<_SendOtp> get copyWith => __$SendOtpCopyWithImpl<_SendOtp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendOtp&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode => Object.hash(runtimeType,phone);

@override
String toString() {
  return 'LoginEvent.sendOtp(phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$SendOtpCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory _$SendOtpCopyWith(_SendOtp value, $Res Function(_SendOtp) _then) = __$SendOtpCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class __$SendOtpCopyWithImpl<$Res>
    implements _$SendOtpCopyWith<$Res> {
  __$SendOtpCopyWithImpl(this._self, this._then);

  final _SendOtp _self;
  final $Res Function(_SendOtp) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(_SendOtp(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _OtpReceiving value)?  otpReceiving,TResult Function( _OtpReceived value)?  otpReceived,TResult Function( _OtpReceivingFailure value)?  otpReceivingFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _OtpReceiving() when otpReceiving != null:
return otpReceiving(_that);case _OtpReceived() when otpReceived != null:
return otpReceived(_that);case _OtpReceivingFailure() when otpReceivingFailure != null:
return otpReceivingFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _OtpReceiving value)  otpReceiving,required TResult Function( _OtpReceived value)  otpReceived,required TResult Function( _OtpReceivingFailure value)  otpReceivingFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _OtpReceiving():
return otpReceiving(_that);case _OtpReceived():
return otpReceived(_that);case _OtpReceivingFailure():
return otpReceivingFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _OtpReceiving value)?  otpReceiving,TResult? Function( _OtpReceived value)?  otpReceived,TResult? Function( _OtpReceivingFailure value)?  otpReceivingFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _OtpReceiving() when otpReceiving != null:
return otpReceiving(_that);case _OtpReceived() when otpReceived != null:
return otpReceived(_that);case _OtpReceivingFailure() when otpReceivingFailure != null:
return otpReceivingFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  otpReceiving,TResult Function( OtpEntity otpEntity)?  otpReceived,TResult Function( String msg)?  otpReceivingFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _OtpReceiving() when otpReceiving != null:
return otpReceiving();case _OtpReceived() when otpReceived != null:
return otpReceived(_that.otpEntity);case _OtpReceivingFailure() when otpReceivingFailure != null:
return otpReceivingFailure(_that.msg);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  otpReceiving,required TResult Function( OtpEntity otpEntity)  otpReceived,required TResult Function( String msg)  otpReceivingFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _OtpReceiving():
return otpReceiving();case _OtpReceived():
return otpReceived(_that.otpEntity);case _OtpReceivingFailure():
return otpReceivingFailure(_that.msg);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  otpReceiving,TResult? Function( OtpEntity otpEntity)?  otpReceived,TResult? Function( String msg)?  otpReceivingFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _OtpReceiving() when otpReceiving != null:
return otpReceiving();case _OtpReceived() when otpReceived != null:
return otpReceived(_that.otpEntity);case _OtpReceivingFailure() when otpReceivingFailure != null:
return otpReceivingFailure(_that.msg);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LoginState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.initial()';
}


}




/// @nodoc


class _OtpReceiving implements LoginState {
  const _OtpReceiving();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpReceiving);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.otpReceiving()';
}


}




/// @nodoc


class _OtpReceived implements LoginState {
  const _OtpReceived({required this.otpEntity});
  

 final  OtpEntity otpEntity;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpReceivedCopyWith<_OtpReceived> get copyWith => __$OtpReceivedCopyWithImpl<_OtpReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpReceived&&(identical(other.otpEntity, otpEntity) || other.otpEntity == otpEntity));
}


@override
int get hashCode => Object.hash(runtimeType,otpEntity);

@override
String toString() {
  return 'LoginState.otpReceived(otpEntity: $otpEntity)';
}


}

/// @nodoc
abstract mixin class _$OtpReceivedCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$OtpReceivedCopyWith(_OtpReceived value, $Res Function(_OtpReceived) _then) = __$OtpReceivedCopyWithImpl;
@useResult
$Res call({
 OtpEntity otpEntity
});




}
/// @nodoc
class __$OtpReceivedCopyWithImpl<$Res>
    implements _$OtpReceivedCopyWith<$Res> {
  __$OtpReceivedCopyWithImpl(this._self, this._then);

  final _OtpReceived _self;
  final $Res Function(_OtpReceived) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? otpEntity = null,}) {
  return _then(_OtpReceived(
otpEntity: null == otpEntity ? _self.otpEntity : otpEntity // ignore: cast_nullable_to_non_nullable
as OtpEntity,
  ));
}


}

/// @nodoc


class _OtpReceivingFailure implements LoginState {
  const _OtpReceivingFailure({required this.msg});
  

 final  String msg;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpReceivingFailureCopyWith<_OtpReceivingFailure> get copyWith => __$OtpReceivingFailureCopyWithImpl<_OtpReceivingFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpReceivingFailure&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,msg);

@override
String toString() {
  return 'LoginState.otpReceivingFailure(msg: $msg)';
}


}

/// @nodoc
abstract mixin class _$OtpReceivingFailureCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$OtpReceivingFailureCopyWith(_OtpReceivingFailure value, $Res Function(_OtpReceivingFailure) _then) = __$OtpReceivingFailureCopyWithImpl;
@useResult
$Res call({
 String msg
});




}
/// @nodoc
class __$OtpReceivingFailureCopyWithImpl<$Res>
    implements _$OtpReceivingFailureCopyWith<$Res> {
  __$OtpReceivingFailureCopyWithImpl(this._self, this._then);

  final _OtpReceivingFailure _self;
  final $Res Function(_OtpReceivingFailure) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? msg = null,}) {
  return _then(_OtpReceivingFailure(
msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
