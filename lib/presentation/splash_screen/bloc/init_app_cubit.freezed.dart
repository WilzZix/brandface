// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'init_app_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InitAppState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitAppState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InitAppState()';
}


}

/// @nodoc
class $InitAppStateCopyWith<$Res>  {
$InitAppStateCopyWith(InitAppState _, $Res Function(InitAppState) __);
}


/// Adds pattern-matching-related methods to [InitAppState].
extension InitAppStatePatterns on InitAppState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _AppInitialized value)?  appInitialized,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _AppInitialized() when appInitialized != null:
return appInitialized(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _AppInitialized value)  appInitialized,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _AppInitialized():
return appInitialized(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _AppInitialized value)?  appInitialized,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _AppInitialized() when appInitialized != null:
return appInitialized(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( bool isLoggedIn,  String? role)?  appInitialized,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _AppInitialized() when appInitialized != null:
return appInitialized(_that.isLoggedIn,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( bool isLoggedIn,  String? role)  appInitialized,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _AppInitialized():
return appInitialized(_that.isLoggedIn,_that.role);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( bool isLoggedIn,  String? role)?  appInitialized,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _AppInitialized() when appInitialized != null:
return appInitialized(_that.isLoggedIn,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements InitAppState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InitAppState.initial()';
}


}




/// @nodoc


class _AppInitialized implements InitAppState {
  const _AppInitialized(this.isLoggedIn, {this.role});
  

 final  bool isLoggedIn;
 final  String? role;

/// Create a copy of InitAppState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppInitializedCopyWith<_AppInitialized> get copyWith => __$AppInitializedCopyWithImpl<_AppInitialized>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppInitialized&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,isLoggedIn,role);

@override
String toString() {
  return 'InitAppState.appInitialized(isLoggedIn: $isLoggedIn, role: $role)';
}


}

/// @nodoc
abstract mixin class _$AppInitializedCopyWith<$Res> implements $InitAppStateCopyWith<$Res> {
  factory _$AppInitializedCopyWith(_AppInitialized value, $Res Function(_AppInitialized) _then) = __$AppInitializedCopyWithImpl;
@useResult
$Res call({
 bool isLoggedIn, String? role
});




}
/// @nodoc
class __$AppInitializedCopyWithImpl<$Res>
    implements _$AppInitializedCopyWith<$Res> {
  __$AppInitializedCopyWithImpl(this._self, this._then);

  final _AppInitialized _self;
  final $Res Function(_AppInitialized) _then;

/// Create a copy of InitAppState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isLoggedIn = null,Object? role = freezed,}) {
  return _then(_AppInitialized(
null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
