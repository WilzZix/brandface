// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_type_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceTypeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceTypeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceTypeState()';
}


}

/// @nodoc
class $ServiceTypeStateCopyWith<$Res>  {
$ServiceTypeStateCopyWith(ServiceTypeState _, $Res Function(ServiceTypeState) __);
}


/// Adds pattern-matching-related methods to [ServiceTypeState].
extension ServiceTypeStatePatterns on ServiceTypeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _ServiceTypeLoaded value)?  categoryLoaded,TResult Function( _ServiceTypeLoadFailure value)?  serviceTypeLoadedLoadFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _ServiceTypeLoaded() when categoryLoaded != null:
return categoryLoaded(_that);case _ServiceTypeLoadFailure() when serviceTypeLoadedLoadFailure != null:
return serviceTypeLoadedLoadFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _ServiceTypeLoaded value)  categoryLoaded,required TResult Function( _ServiceTypeLoadFailure value)  serviceTypeLoadedLoadFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _ServiceTypeLoaded():
return categoryLoaded(_that);case _ServiceTypeLoadFailure():
return serviceTypeLoadedLoadFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _ServiceTypeLoaded value)?  categoryLoaded,TResult? Function( _ServiceTypeLoadFailure value)?  serviceTypeLoadedLoadFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _ServiceTypeLoaded() when categoryLoaded != null:
return categoryLoaded(_that);case _ServiceTypeLoadFailure() when serviceTypeLoadedLoadFailure != null:
return serviceTypeLoadedLoadFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ServiceTypeEntity> data)?  categoryLoaded,TResult Function( Failure failure)?  serviceTypeLoadedLoadFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _ServiceTypeLoaded() when categoryLoaded != null:
return categoryLoaded(_that.data);case _ServiceTypeLoadFailure() when serviceTypeLoadedLoadFailure != null:
return serviceTypeLoadedLoadFailure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ServiceTypeEntity> data)  categoryLoaded,required TResult Function( Failure failure)  serviceTypeLoadedLoadFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _ServiceTypeLoaded():
return categoryLoaded(_that.data);case _ServiceTypeLoadFailure():
return serviceTypeLoadedLoadFailure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ServiceTypeEntity> data)?  categoryLoaded,TResult? Function( Failure failure)?  serviceTypeLoadedLoadFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _ServiceTypeLoaded() when categoryLoaded != null:
return categoryLoaded(_that.data);case _ServiceTypeLoadFailure() when serviceTypeLoadedLoadFailure != null:
return serviceTypeLoadedLoadFailure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ServiceTypeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceTypeState.initial()';
}


}




/// @nodoc


class _Loading implements ServiceTypeState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceTypeState.loading()';
}


}




/// @nodoc


class _ServiceTypeLoaded implements ServiceTypeState {
  const _ServiceTypeLoaded({required final  List<ServiceTypeEntity> data}): _data = data;
  

 final  List<ServiceTypeEntity> _data;
 List<ServiceTypeEntity> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of ServiceTypeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceTypeLoadedCopyWith<_ServiceTypeLoaded> get copyWith => __$ServiceTypeLoadedCopyWithImpl<_ServiceTypeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceTypeLoaded&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'ServiceTypeState.categoryLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$ServiceTypeLoadedCopyWith<$Res> implements $ServiceTypeStateCopyWith<$Res> {
  factory _$ServiceTypeLoadedCopyWith(_ServiceTypeLoaded value, $Res Function(_ServiceTypeLoaded) _then) = __$ServiceTypeLoadedCopyWithImpl;
@useResult
$Res call({
 List<ServiceTypeEntity> data
});




}
/// @nodoc
class __$ServiceTypeLoadedCopyWithImpl<$Res>
    implements _$ServiceTypeLoadedCopyWith<$Res> {
  __$ServiceTypeLoadedCopyWithImpl(this._self, this._then);

  final _ServiceTypeLoaded _self;
  final $Res Function(_ServiceTypeLoaded) _then;

/// Create a copy of ServiceTypeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_ServiceTypeLoaded(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<ServiceTypeEntity>,
  ));
}


}

/// @nodoc


class _ServiceTypeLoadFailure implements ServiceTypeState {
  const _ServiceTypeLoadFailure({required this.failure});
  

 final  Failure failure;

/// Create a copy of ServiceTypeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceTypeLoadFailureCopyWith<_ServiceTypeLoadFailure> get copyWith => __$ServiceTypeLoadFailureCopyWithImpl<_ServiceTypeLoadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceTypeLoadFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ServiceTypeState.serviceTypeLoadedLoadFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$ServiceTypeLoadFailureCopyWith<$Res> implements $ServiceTypeStateCopyWith<$Res> {
  factory _$ServiceTypeLoadFailureCopyWith(_ServiceTypeLoadFailure value, $Res Function(_ServiceTypeLoadFailure) _then) = __$ServiceTypeLoadFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class __$ServiceTypeLoadFailureCopyWithImpl<$Res>
    implements _$ServiceTypeLoadFailureCopyWith<$Res> {
  __$ServiceTypeLoadFailureCopyWithImpl(this._self, this._then);

  final _ServiceTypeLoadFailure _self;
  final $Res Function(_ServiceTypeLoadFailure) _then;

/// Create a copy of ServiceTypeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_ServiceTypeLoadFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
