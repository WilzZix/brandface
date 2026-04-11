// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegionState()';
}


}

/// @nodoc
class $RegionStateCopyWith<$Res>  {
$RegionStateCopyWith(RegionState _, $Res Function(RegionState) __);
}


/// Adds pattern-matching-related methods to [RegionState].
extension RegionStatePatterns on RegionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _RegionsLoaded value)?  regionsLoaded,TResult Function( _RegionLoadFailure value)?  regionLoadFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _RegionsLoaded() when regionsLoaded != null:
return regionsLoaded(_that);case _RegionLoadFailure() when regionLoadFailure != null:
return regionLoadFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _RegionsLoaded value)  regionsLoaded,required TResult Function( _RegionLoadFailure value)  regionLoadFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _RegionsLoaded():
return regionsLoaded(_that);case _RegionLoadFailure():
return regionLoadFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _RegionsLoaded value)?  regionsLoaded,TResult? Function( _RegionLoadFailure value)?  regionLoadFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _RegionsLoaded() when regionsLoaded != null:
return regionsLoaded(_that);case _RegionLoadFailure() when regionLoadFailure != null:
return regionLoadFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<RegionEntity> data)?  regionsLoaded,TResult Function( Failure failure)?  regionLoadFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _RegionsLoaded() when regionsLoaded != null:
return regionsLoaded(_that.data);case _RegionLoadFailure() when regionLoadFailure != null:
return regionLoadFailure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<RegionEntity> data)  regionsLoaded,required TResult Function( Failure failure)  regionLoadFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _RegionsLoaded():
return regionsLoaded(_that.data);case _RegionLoadFailure():
return regionLoadFailure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<RegionEntity> data)?  regionsLoaded,TResult? Function( Failure failure)?  regionLoadFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _RegionsLoaded() when regionsLoaded != null:
return regionsLoaded(_that.data);case _RegionLoadFailure() when regionLoadFailure != null:
return regionLoadFailure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements RegionState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegionState.initial()';
}


}




/// @nodoc


class _Loading implements RegionState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegionState.loading()';
}


}




/// @nodoc


class _RegionsLoaded implements RegionState {
  const _RegionsLoaded({required final  List<RegionEntity> data}): _data = data;
  

 final  List<RegionEntity> _data;
 List<RegionEntity> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of RegionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionsLoadedCopyWith<_RegionsLoaded> get copyWith => __$RegionsLoadedCopyWithImpl<_RegionsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionsLoaded&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'RegionState.regionsLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$RegionsLoadedCopyWith<$Res> implements $RegionStateCopyWith<$Res> {
  factory _$RegionsLoadedCopyWith(_RegionsLoaded value, $Res Function(_RegionsLoaded) _then) = __$RegionsLoadedCopyWithImpl;
@useResult
$Res call({
 List<RegionEntity> data
});




}
/// @nodoc
class __$RegionsLoadedCopyWithImpl<$Res>
    implements _$RegionsLoadedCopyWith<$Res> {
  __$RegionsLoadedCopyWithImpl(this._self, this._then);

  final _RegionsLoaded _self;
  final $Res Function(_RegionsLoaded) _then;

/// Create a copy of RegionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_RegionsLoaded(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<RegionEntity>,
  ));
}


}

/// @nodoc


class _RegionLoadFailure implements RegionState {
  const _RegionLoadFailure({required this.failure});
  

 final  Failure failure;

/// Create a copy of RegionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionLoadFailureCopyWith<_RegionLoadFailure> get copyWith => __$RegionLoadFailureCopyWithImpl<_RegionLoadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionLoadFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'RegionState.regionLoadFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RegionLoadFailureCopyWith<$Res> implements $RegionStateCopyWith<$Res> {
  factory _$RegionLoadFailureCopyWith(_RegionLoadFailure value, $Res Function(_RegionLoadFailure) _then) = __$RegionLoadFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class __$RegionLoadFailureCopyWithImpl<$Res>
    implements _$RegionLoadFailureCopyWith<$Res> {
  __$RegionLoadFailureCopyWithImpl(this._self, this._then);

  final _RegionLoadFailure _self;
  final $Res Function(_RegionLoadFailure) _then;

/// Create a copy of RegionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_RegionLoadFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
