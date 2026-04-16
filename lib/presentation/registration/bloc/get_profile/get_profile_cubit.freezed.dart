// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetProfileState()';
}


}

/// @nodoc
class $GetProfileStateCopyWith<$Res>  {
$GetProfileStateCopyWith(GetProfileState _, $Res Function(GetProfileState) __);
}


/// Adds pattern-matching-related methods to [GetProfileState].
extension GetProfileStatePatterns on GetProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _ProfileLoaded value)?  profileLoaded,TResult Function( _ProfileLoadFailure value)?  profileLoadFailure,TResult Function( _ProfileLoading value)?  profileLoading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ProfileLoaded() when profileLoaded != null:
return profileLoaded(_that);case _ProfileLoadFailure() when profileLoadFailure != null:
return profileLoadFailure(_that);case _ProfileLoading() when profileLoading != null:
return profileLoading(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _ProfileLoaded value)  profileLoaded,required TResult Function( _ProfileLoadFailure value)  profileLoadFailure,required TResult Function( _ProfileLoading value)  profileLoading,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _ProfileLoaded():
return profileLoaded(_that);case _ProfileLoadFailure():
return profileLoadFailure(_that);case _ProfileLoading():
return profileLoading(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _ProfileLoaded value)?  profileLoaded,TResult? Function( _ProfileLoadFailure value)?  profileLoadFailure,TResult? Function( _ProfileLoading value)?  profileLoading,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _ProfileLoaded() when profileLoaded != null:
return profileLoaded(_that);case _ProfileLoadFailure() when profileLoadFailure != null:
return profileLoadFailure(_that);case _ProfileLoading() when profileLoading != null:
return profileLoading(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( ProfileEntity profile)?  profileLoaded,TResult Function( Failure fl)?  profileLoadFailure,TResult Function()?  profileLoading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ProfileLoaded() when profileLoaded != null:
return profileLoaded(_that.profile);case _ProfileLoadFailure() when profileLoadFailure != null:
return profileLoadFailure(_that.fl);case _ProfileLoading() when profileLoading != null:
return profileLoading();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( ProfileEntity profile)  profileLoaded,required TResult Function( Failure fl)  profileLoadFailure,required TResult Function()  profileLoading,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _ProfileLoaded():
return profileLoaded(_that.profile);case _ProfileLoadFailure():
return profileLoadFailure(_that.fl);case _ProfileLoading():
return profileLoading();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( ProfileEntity profile)?  profileLoaded,TResult? Function( Failure fl)?  profileLoadFailure,TResult? Function()?  profileLoading,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _ProfileLoaded() when profileLoaded != null:
return profileLoaded(_that.profile);case _ProfileLoadFailure() when profileLoadFailure != null:
return profileLoadFailure(_that.fl);case _ProfileLoading() when profileLoading != null:
return profileLoading();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements GetProfileState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetProfileState.initial()';
}


}




/// @nodoc


class _ProfileLoaded implements GetProfileState {
  const _ProfileLoaded({required this.profile});
  

 final  ProfileEntity profile;

/// Create a copy of GetProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileLoadedCopyWith<_ProfileLoaded> get copyWith => __$ProfileLoadedCopyWithImpl<_ProfileLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileLoaded&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'GetProfileState.profileLoaded(profile: $profile)';
}


}

/// @nodoc
abstract mixin class _$ProfileLoadedCopyWith<$Res> implements $GetProfileStateCopyWith<$Res> {
  factory _$ProfileLoadedCopyWith(_ProfileLoaded value, $Res Function(_ProfileLoaded) _then) = __$ProfileLoadedCopyWithImpl;
@useResult
$Res call({
 ProfileEntity profile
});




}
/// @nodoc
class __$ProfileLoadedCopyWithImpl<$Res>
    implements _$ProfileLoadedCopyWith<$Res> {
  __$ProfileLoadedCopyWithImpl(this._self, this._then);

  final _ProfileLoaded _self;
  final $Res Function(_ProfileLoaded) _then;

/// Create a copy of GetProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(_ProfileLoaded(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileEntity,
  ));
}


}

/// @nodoc


class _ProfileLoadFailure implements GetProfileState {
  const _ProfileLoadFailure({required this.fl});
  

 final  Failure fl;

/// Create a copy of GetProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileLoadFailureCopyWith<_ProfileLoadFailure> get copyWith => __$ProfileLoadFailureCopyWithImpl<_ProfileLoadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileLoadFailure&&(identical(other.fl, fl) || other.fl == fl));
}


@override
int get hashCode => Object.hash(runtimeType,fl);

@override
String toString() {
  return 'GetProfileState.profileLoadFailure(fl: $fl)';
}


}

/// @nodoc
abstract mixin class _$ProfileLoadFailureCopyWith<$Res> implements $GetProfileStateCopyWith<$Res> {
  factory _$ProfileLoadFailureCopyWith(_ProfileLoadFailure value, $Res Function(_ProfileLoadFailure) _then) = __$ProfileLoadFailureCopyWithImpl;
@useResult
$Res call({
 Failure fl
});




}
/// @nodoc
class __$ProfileLoadFailureCopyWithImpl<$Res>
    implements _$ProfileLoadFailureCopyWith<$Res> {
  __$ProfileLoadFailureCopyWithImpl(this._self, this._then);

  final _ProfileLoadFailure _self;
  final $Res Function(_ProfileLoadFailure) _then;

/// Create a copy of GetProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fl = null,}) {
  return _then(_ProfileLoadFailure(
fl: null == fl ? _self.fl : fl // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class _ProfileLoading implements GetProfileState {
  const _ProfileLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetProfileState.profileLoading()';
}


}




// dart format on
