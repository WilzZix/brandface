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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _SendOtp value)?  sendOtp,TResult Function( _VerifyOtp value)?  verifyOtp,TResult Function( _SocialLogin value)?  socialLogin,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SendOtp() when sendOtp != null:
return sendOtp(_that);case _VerifyOtp() when verifyOtp != null:
return verifyOtp(_that);case _SocialLogin() when socialLogin != null:
return socialLogin(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _SendOtp value)  sendOtp,required TResult Function( _VerifyOtp value)  verifyOtp,required TResult Function( _SocialLogin value)  socialLogin,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _SendOtp():
return sendOtp(_that);case _VerifyOtp():
return verifyOtp(_that);case _SocialLogin():
return socialLogin(_that);case _Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _SendOtp value)?  sendOtp,TResult? Function( _VerifyOtp value)?  verifyOtp,TResult? Function( _SocialLogin value)?  socialLogin,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _SendOtp() when sendOtp != null:
return sendOtp(_that);case _VerifyOtp() when verifyOtp != null:
return verifyOtp(_that);case _SocialLogin() when socialLogin != null:
return socialLogin(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String phone)?  sendOtp,TResult Function( VerifyOtpParams params)?  verifyOtp,TResult Function( SocialProvider provider,  BuildContext context)?  socialLogin,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SendOtp() when sendOtp != null:
return sendOtp(_that.phone);case _VerifyOtp() when verifyOtp != null:
return verifyOtp(_that.params);case _SocialLogin() when socialLogin != null:
return socialLogin(_that.provider,_that.context);case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String phone)  sendOtp,required TResult Function( VerifyOtpParams params)  verifyOtp,required TResult Function( SocialProvider provider,  BuildContext context)  socialLogin,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _SendOtp():
return sendOtp(_that.phone);case _VerifyOtp():
return verifyOtp(_that.params);case _SocialLogin():
return socialLogin(_that.provider,_that.context);case _Reset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String phone)?  sendOtp,TResult? Function( VerifyOtpParams params)?  verifyOtp,TResult? Function( SocialProvider provider,  BuildContext context)?  socialLogin,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _SendOtp() when sendOtp != null:
return sendOtp(_that.phone);case _VerifyOtp() when verifyOtp != null:
return verifyOtp(_that.params);case _SocialLogin() when socialLogin != null:
return socialLogin(_that.provider,_that.context);case _Reset() when reset != null:
return reset();case _:
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


class _VerifyOtp implements LoginEvent {
  const _VerifyOtp({required this.params});
  

 final  VerifyOtpParams params;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpCopyWith<_VerifyOtp> get copyWith => __$VerifyOtpCopyWithImpl<_VerifyOtp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtp&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'LoginEvent.verifyOtp(params: $params)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory _$VerifyOtpCopyWith(_VerifyOtp value, $Res Function(_VerifyOtp) _then) = __$VerifyOtpCopyWithImpl;
@useResult
$Res call({
 VerifyOtpParams params
});




}
/// @nodoc
class __$VerifyOtpCopyWithImpl<$Res>
    implements _$VerifyOtpCopyWith<$Res> {
  __$VerifyOtpCopyWithImpl(this._self, this._then);

  final _VerifyOtp _self;
  final $Res Function(_VerifyOtp) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(_VerifyOtp(
params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as VerifyOtpParams,
  ));
}


}

/// @nodoc


class _SocialLogin implements LoginEvent {
  const _SocialLogin({required this.provider, required this.context});
  

 final  SocialProvider provider;
 final  BuildContext context;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLoginCopyWith<_SocialLogin> get copyWith => __$SocialLoginCopyWithImpl<_SocialLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLogin&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.context, context) || other.context == context));
}


@override
int get hashCode => Object.hash(runtimeType,provider,context);

@override
String toString() {
  return 'LoginEvent.socialLogin(provider: $provider, context: $context)';
}


}

/// @nodoc
abstract mixin class _$SocialLoginCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory _$SocialLoginCopyWith(_SocialLogin value, $Res Function(_SocialLogin) _then) = __$SocialLoginCopyWithImpl;
@useResult
$Res call({
 SocialProvider provider, BuildContext context
});




}
/// @nodoc
class __$SocialLoginCopyWithImpl<$Res>
    implements _$SocialLoginCopyWith<$Res> {
  __$SocialLoginCopyWithImpl(this._self, this._then);

  final _SocialLogin _self;
  final $Res Function(_SocialLogin) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? context = null,}) {
  return _then(_SocialLogin(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as BuildContext,
  ));
}


}

/// @nodoc


class _Reset implements LoginEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.reset()';
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _OtpReceiving value)?  otpReceiving,TResult Function( _OtpReceived value)?  otpReceived,TResult Function( _OtpReceivingFailure value)?  otpReceivingFailure,TResult Function( _VerifyingOtp value)?  verifyingOtp,TResult Function( _OtpVeiried value)?  otpVerified,TResult Function( _VerifyingOtpFailure value)?  verifyingOtpFailure,TResult Function( _SocialAuthInProgress value)?  socialAuthInProgress,TResult Function( _SocialAuthSuccess value)?  socialAuthSuccess,TResult Function( _SocialAuthFailure value)?  socialAuthFailure,TResult Function( _SocialAuthSoon value)?  socialAuthSoon,TResult Function( _SocialAuthCancelled value)?  socialAuthCancelled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _OtpReceiving() when otpReceiving != null:
return otpReceiving(_that);case _OtpReceived() when otpReceived != null:
return otpReceived(_that);case _OtpReceivingFailure() when otpReceivingFailure != null:
return otpReceivingFailure(_that);case _VerifyingOtp() when verifyingOtp != null:
return verifyingOtp(_that);case _OtpVeiried() when otpVerified != null:
return otpVerified(_that);case _VerifyingOtpFailure() when verifyingOtpFailure != null:
return verifyingOtpFailure(_that);case _SocialAuthInProgress() when socialAuthInProgress != null:
return socialAuthInProgress(_that);case _SocialAuthSuccess() when socialAuthSuccess != null:
return socialAuthSuccess(_that);case _SocialAuthFailure() when socialAuthFailure != null:
return socialAuthFailure(_that);case _SocialAuthSoon() when socialAuthSoon != null:
return socialAuthSoon(_that);case _SocialAuthCancelled() when socialAuthCancelled != null:
return socialAuthCancelled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _OtpReceiving value)  otpReceiving,required TResult Function( _OtpReceived value)  otpReceived,required TResult Function( _OtpReceivingFailure value)  otpReceivingFailure,required TResult Function( _VerifyingOtp value)  verifyingOtp,required TResult Function( _OtpVeiried value)  otpVerified,required TResult Function( _VerifyingOtpFailure value)  verifyingOtpFailure,required TResult Function( _SocialAuthInProgress value)  socialAuthInProgress,required TResult Function( _SocialAuthSuccess value)  socialAuthSuccess,required TResult Function( _SocialAuthFailure value)  socialAuthFailure,required TResult Function( _SocialAuthSoon value)  socialAuthSoon,required TResult Function( _SocialAuthCancelled value)  socialAuthCancelled,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _OtpReceiving():
return otpReceiving(_that);case _OtpReceived():
return otpReceived(_that);case _OtpReceivingFailure():
return otpReceivingFailure(_that);case _VerifyingOtp():
return verifyingOtp(_that);case _OtpVeiried():
return otpVerified(_that);case _VerifyingOtpFailure():
return verifyingOtpFailure(_that);case _SocialAuthInProgress():
return socialAuthInProgress(_that);case _SocialAuthSuccess():
return socialAuthSuccess(_that);case _SocialAuthFailure():
return socialAuthFailure(_that);case _SocialAuthSoon():
return socialAuthSoon(_that);case _SocialAuthCancelled():
return socialAuthCancelled(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _OtpReceiving value)?  otpReceiving,TResult? Function( _OtpReceived value)?  otpReceived,TResult? Function( _OtpReceivingFailure value)?  otpReceivingFailure,TResult? Function( _VerifyingOtp value)?  verifyingOtp,TResult? Function( _OtpVeiried value)?  otpVerified,TResult? Function( _VerifyingOtpFailure value)?  verifyingOtpFailure,TResult? Function( _SocialAuthInProgress value)?  socialAuthInProgress,TResult? Function( _SocialAuthSuccess value)?  socialAuthSuccess,TResult? Function( _SocialAuthFailure value)?  socialAuthFailure,TResult? Function( _SocialAuthSoon value)?  socialAuthSoon,TResult? Function( _SocialAuthCancelled value)?  socialAuthCancelled,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _OtpReceiving() when otpReceiving != null:
return otpReceiving(_that);case _OtpReceived() when otpReceived != null:
return otpReceived(_that);case _OtpReceivingFailure() when otpReceivingFailure != null:
return otpReceivingFailure(_that);case _VerifyingOtp() when verifyingOtp != null:
return verifyingOtp(_that);case _OtpVeiried() when otpVerified != null:
return otpVerified(_that);case _VerifyingOtpFailure() when verifyingOtpFailure != null:
return verifyingOtpFailure(_that);case _SocialAuthInProgress() when socialAuthInProgress != null:
return socialAuthInProgress(_that);case _SocialAuthSuccess() when socialAuthSuccess != null:
return socialAuthSuccess(_that);case _SocialAuthFailure() when socialAuthFailure != null:
return socialAuthFailure(_that);case _SocialAuthSoon() when socialAuthSoon != null:
return socialAuthSoon(_that);case _SocialAuthCancelled() when socialAuthCancelled != null:
return socialAuthCancelled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  otpReceiving,TResult Function( OtpEntity otpEntity)?  otpReceived,TResult Function( String msg)?  otpReceivingFailure,TResult Function()?  verifyingOtp,TResult Function( VerifyOtpEntity otpEntity)?  otpVerified,TResult Function( String msg)?  verifyingOtpFailure,TResult Function( SocialProvider provider)?  socialAuthInProgress,TResult Function( SocialAuthEntity entity)?  socialAuthSuccess,TResult Function( SocialProvider provider,  String msg)?  socialAuthFailure,TResult Function( SocialProvider provider)?  socialAuthSoon,TResult Function( SocialProvider provider)?  socialAuthCancelled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _OtpReceiving() when otpReceiving != null:
return otpReceiving();case _OtpReceived() when otpReceived != null:
return otpReceived(_that.otpEntity);case _OtpReceivingFailure() when otpReceivingFailure != null:
return otpReceivingFailure(_that.msg);case _VerifyingOtp() when verifyingOtp != null:
return verifyingOtp();case _OtpVeiried() when otpVerified != null:
return otpVerified(_that.otpEntity);case _VerifyingOtpFailure() when verifyingOtpFailure != null:
return verifyingOtpFailure(_that.msg);case _SocialAuthInProgress() when socialAuthInProgress != null:
return socialAuthInProgress(_that.provider);case _SocialAuthSuccess() when socialAuthSuccess != null:
return socialAuthSuccess(_that.entity);case _SocialAuthFailure() when socialAuthFailure != null:
return socialAuthFailure(_that.provider,_that.msg);case _SocialAuthSoon() when socialAuthSoon != null:
return socialAuthSoon(_that.provider);case _SocialAuthCancelled() when socialAuthCancelled != null:
return socialAuthCancelled(_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  otpReceiving,required TResult Function( OtpEntity otpEntity)  otpReceived,required TResult Function( String msg)  otpReceivingFailure,required TResult Function()  verifyingOtp,required TResult Function( VerifyOtpEntity otpEntity)  otpVerified,required TResult Function( String msg)  verifyingOtpFailure,required TResult Function( SocialProvider provider)  socialAuthInProgress,required TResult Function( SocialAuthEntity entity)  socialAuthSuccess,required TResult Function( SocialProvider provider,  String msg)  socialAuthFailure,required TResult Function( SocialProvider provider)  socialAuthSoon,required TResult Function( SocialProvider provider)  socialAuthCancelled,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _OtpReceiving():
return otpReceiving();case _OtpReceived():
return otpReceived(_that.otpEntity);case _OtpReceivingFailure():
return otpReceivingFailure(_that.msg);case _VerifyingOtp():
return verifyingOtp();case _OtpVeiried():
return otpVerified(_that.otpEntity);case _VerifyingOtpFailure():
return verifyingOtpFailure(_that.msg);case _SocialAuthInProgress():
return socialAuthInProgress(_that.provider);case _SocialAuthSuccess():
return socialAuthSuccess(_that.entity);case _SocialAuthFailure():
return socialAuthFailure(_that.provider,_that.msg);case _SocialAuthSoon():
return socialAuthSoon(_that.provider);case _SocialAuthCancelled():
return socialAuthCancelled(_that.provider);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  otpReceiving,TResult? Function( OtpEntity otpEntity)?  otpReceived,TResult? Function( String msg)?  otpReceivingFailure,TResult? Function()?  verifyingOtp,TResult? Function( VerifyOtpEntity otpEntity)?  otpVerified,TResult? Function( String msg)?  verifyingOtpFailure,TResult? Function( SocialProvider provider)?  socialAuthInProgress,TResult? Function( SocialAuthEntity entity)?  socialAuthSuccess,TResult? Function( SocialProvider provider,  String msg)?  socialAuthFailure,TResult? Function( SocialProvider provider)?  socialAuthSoon,TResult? Function( SocialProvider provider)?  socialAuthCancelled,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _OtpReceiving() when otpReceiving != null:
return otpReceiving();case _OtpReceived() when otpReceived != null:
return otpReceived(_that.otpEntity);case _OtpReceivingFailure() when otpReceivingFailure != null:
return otpReceivingFailure(_that.msg);case _VerifyingOtp() when verifyingOtp != null:
return verifyingOtp();case _OtpVeiried() when otpVerified != null:
return otpVerified(_that.otpEntity);case _VerifyingOtpFailure() when verifyingOtpFailure != null:
return verifyingOtpFailure(_that.msg);case _SocialAuthInProgress() when socialAuthInProgress != null:
return socialAuthInProgress(_that.provider);case _SocialAuthSuccess() when socialAuthSuccess != null:
return socialAuthSuccess(_that.entity);case _SocialAuthFailure() when socialAuthFailure != null:
return socialAuthFailure(_that.provider,_that.msg);case _SocialAuthSoon() when socialAuthSoon != null:
return socialAuthSoon(_that.provider);case _SocialAuthCancelled() when socialAuthCancelled != null:
return socialAuthCancelled(_that.provider);case _:
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

/// @nodoc


class _VerifyingOtp implements LoginState {
  const _VerifyingOtp();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyingOtp);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.verifyingOtp()';
}


}




/// @nodoc


class _OtpVeiried implements LoginState {
  const _OtpVeiried({required this.otpEntity});
  

 final  VerifyOtpEntity otpEntity;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpVeiriedCopyWith<_OtpVeiried> get copyWith => __$OtpVeiriedCopyWithImpl<_OtpVeiried>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpVeiried&&(identical(other.otpEntity, otpEntity) || other.otpEntity == otpEntity));
}


@override
int get hashCode => Object.hash(runtimeType,otpEntity);

@override
String toString() {
  return 'LoginState.otpVerified(otpEntity: $otpEntity)';
}


}

/// @nodoc
abstract mixin class _$OtpVeiriedCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$OtpVeiriedCopyWith(_OtpVeiried value, $Res Function(_OtpVeiried) _then) = __$OtpVeiriedCopyWithImpl;
@useResult
$Res call({
 VerifyOtpEntity otpEntity
});




}
/// @nodoc
class __$OtpVeiriedCopyWithImpl<$Res>
    implements _$OtpVeiriedCopyWith<$Res> {
  __$OtpVeiriedCopyWithImpl(this._self, this._then);

  final _OtpVeiried _self;
  final $Res Function(_OtpVeiried) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? otpEntity = null,}) {
  return _then(_OtpVeiried(
otpEntity: null == otpEntity ? _self.otpEntity : otpEntity // ignore: cast_nullable_to_non_nullable
as VerifyOtpEntity,
  ));
}


}

/// @nodoc


class _VerifyingOtpFailure implements LoginState {
  const _VerifyingOtpFailure({required this.msg});
  

 final  String msg;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyingOtpFailureCopyWith<_VerifyingOtpFailure> get copyWith => __$VerifyingOtpFailureCopyWithImpl<_VerifyingOtpFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyingOtpFailure&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,msg);

@override
String toString() {
  return 'LoginState.verifyingOtpFailure(msg: $msg)';
}


}

/// @nodoc
abstract mixin class _$VerifyingOtpFailureCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$VerifyingOtpFailureCopyWith(_VerifyingOtpFailure value, $Res Function(_VerifyingOtpFailure) _then) = __$VerifyingOtpFailureCopyWithImpl;
@useResult
$Res call({
 String msg
});




}
/// @nodoc
class __$VerifyingOtpFailureCopyWithImpl<$Res>
    implements _$VerifyingOtpFailureCopyWith<$Res> {
  __$VerifyingOtpFailureCopyWithImpl(this._self, this._then);

  final _VerifyingOtpFailure _self;
  final $Res Function(_VerifyingOtpFailure) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? msg = null,}) {
  return _then(_VerifyingOtpFailure(
msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SocialAuthInProgress implements LoginState {
  const _SocialAuthInProgress({required this.provider});
  

 final  SocialProvider provider;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAuthInProgressCopyWith<_SocialAuthInProgress> get copyWith => __$SocialAuthInProgressCopyWithImpl<_SocialAuthInProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAuthInProgress&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode => Object.hash(runtimeType,provider);

@override
String toString() {
  return 'LoginState.socialAuthInProgress(provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$SocialAuthInProgressCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$SocialAuthInProgressCopyWith(_SocialAuthInProgress value, $Res Function(_SocialAuthInProgress) _then) = __$SocialAuthInProgressCopyWithImpl;
@useResult
$Res call({
 SocialProvider provider
});




}
/// @nodoc
class __$SocialAuthInProgressCopyWithImpl<$Res>
    implements _$SocialAuthInProgressCopyWith<$Res> {
  __$SocialAuthInProgressCopyWithImpl(this._self, this._then);

  final _SocialAuthInProgress _self;
  final $Res Function(_SocialAuthInProgress) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(_SocialAuthInProgress(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider,
  ));
}


}

/// @nodoc


class _SocialAuthSuccess implements LoginState {
  const _SocialAuthSuccess({required this.entity});
  

 final  SocialAuthEntity entity;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAuthSuccessCopyWith<_SocialAuthSuccess> get copyWith => __$SocialAuthSuccessCopyWithImpl<_SocialAuthSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAuthSuccess&&(identical(other.entity, entity) || other.entity == entity));
}


@override
int get hashCode => Object.hash(runtimeType,entity);

@override
String toString() {
  return 'LoginState.socialAuthSuccess(entity: $entity)';
}


}

/// @nodoc
abstract mixin class _$SocialAuthSuccessCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$SocialAuthSuccessCopyWith(_SocialAuthSuccess value, $Res Function(_SocialAuthSuccess) _then) = __$SocialAuthSuccessCopyWithImpl;
@useResult
$Res call({
 SocialAuthEntity entity
});




}
/// @nodoc
class __$SocialAuthSuccessCopyWithImpl<$Res>
    implements _$SocialAuthSuccessCopyWith<$Res> {
  __$SocialAuthSuccessCopyWithImpl(this._self, this._then);

  final _SocialAuthSuccess _self;
  final $Res Function(_SocialAuthSuccess) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? entity = null,}) {
  return _then(_SocialAuthSuccess(
entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as SocialAuthEntity,
  ));
}


}

/// @nodoc


class _SocialAuthFailure implements LoginState {
  const _SocialAuthFailure({required this.provider, required this.msg});
  

 final  SocialProvider provider;
 final  String msg;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAuthFailureCopyWith<_SocialAuthFailure> get copyWith => __$SocialAuthFailureCopyWithImpl<_SocialAuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAuthFailure&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.msg, msg) || other.msg == msg));
}


@override
int get hashCode => Object.hash(runtimeType,provider,msg);

@override
String toString() {
  return 'LoginState.socialAuthFailure(provider: $provider, msg: $msg)';
}


}

/// @nodoc
abstract mixin class _$SocialAuthFailureCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$SocialAuthFailureCopyWith(_SocialAuthFailure value, $Res Function(_SocialAuthFailure) _then) = __$SocialAuthFailureCopyWithImpl;
@useResult
$Res call({
 SocialProvider provider, String msg
});




}
/// @nodoc
class __$SocialAuthFailureCopyWithImpl<$Res>
    implements _$SocialAuthFailureCopyWith<$Res> {
  __$SocialAuthFailureCopyWithImpl(this._self, this._then);

  final _SocialAuthFailure _self;
  final $Res Function(_SocialAuthFailure) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? msg = null,}) {
  return _then(_SocialAuthFailure(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider,msg: null == msg ? _self.msg : msg // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SocialAuthSoon implements LoginState {
  const _SocialAuthSoon({required this.provider});
  

 final  SocialProvider provider;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAuthSoonCopyWith<_SocialAuthSoon> get copyWith => __$SocialAuthSoonCopyWithImpl<_SocialAuthSoon>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAuthSoon&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode => Object.hash(runtimeType,provider);

@override
String toString() {
  return 'LoginState.socialAuthSoon(provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$SocialAuthSoonCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$SocialAuthSoonCopyWith(_SocialAuthSoon value, $Res Function(_SocialAuthSoon) _then) = __$SocialAuthSoonCopyWithImpl;
@useResult
$Res call({
 SocialProvider provider
});




}
/// @nodoc
class __$SocialAuthSoonCopyWithImpl<$Res>
    implements _$SocialAuthSoonCopyWith<$Res> {
  __$SocialAuthSoonCopyWithImpl(this._self, this._then);

  final _SocialAuthSoon _self;
  final $Res Function(_SocialAuthSoon) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(_SocialAuthSoon(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider,
  ));
}


}

/// @nodoc


class _SocialAuthCancelled implements LoginState {
  const _SocialAuthCancelled({required this.provider});
  

 final  SocialProvider provider;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAuthCancelledCopyWith<_SocialAuthCancelled> get copyWith => __$SocialAuthCancelledCopyWithImpl<_SocialAuthCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAuthCancelled&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode => Object.hash(runtimeType,provider);

@override
String toString() {
  return 'LoginState.socialAuthCancelled(provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$SocialAuthCancelledCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$SocialAuthCancelledCopyWith(_SocialAuthCancelled value, $Res Function(_SocialAuthCancelled) _then) = __$SocialAuthCancelledCopyWithImpl;
@useResult
$Res call({
 SocialProvider provider
});




}
/// @nodoc
class __$SocialAuthCancelledCopyWithImpl<$Res>
    implements _$SocialAuthCancelledCopyWith<$Res> {
  __$SocialAuthCancelledCopyWithImpl(this._self, this._then);

  final _SocialAuthCancelled _self;
  final $Res Function(_SocialAuthCancelled) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(_SocialAuthCancelled(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider,
  ));
}


}

// dart format on
