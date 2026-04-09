// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState()';
}


}

/// @nodoc
class $CategoryStateCopyWith<$Res>  {
$CategoryStateCopyWith(CategoryState _, $Res Function(CategoryState) __);
}


/// Adds pattern-matching-related methods to [CategoryState].
extension CategoryStatePatterns on CategoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _CategoryLoaded value)?  categoryLoaded,TResult Function( _CategoryLoadFailure value)?  categoryLoadFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CategoryLoaded() when categoryLoaded != null:
return categoryLoaded(_that);case _CategoryLoadFailure() when categoryLoadFailure != null:
return categoryLoadFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _CategoryLoaded value)  categoryLoaded,required TResult Function( _CategoryLoadFailure value)  categoryLoadFailure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _CategoryLoaded():
return categoryLoaded(_that);case _CategoryLoadFailure():
return categoryLoadFailure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _CategoryLoaded value)?  categoryLoaded,TResult? Function( _CategoryLoadFailure value)?  categoryLoadFailure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CategoryLoaded() when categoryLoaded != null:
return categoryLoaded(_that);case _CategoryLoadFailure() when categoryLoadFailure != null:
return categoryLoadFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<CategoryItemEntity> data)?  categoryLoaded,TResult Function( Failure failure)?  categoryLoadFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CategoryLoaded() when categoryLoaded != null:
return categoryLoaded(_that.data);case _CategoryLoadFailure() when categoryLoadFailure != null:
return categoryLoadFailure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<CategoryItemEntity> data)  categoryLoaded,required TResult Function( Failure failure)  categoryLoadFailure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _CategoryLoaded():
return categoryLoaded(_that.data);case _CategoryLoadFailure():
return categoryLoadFailure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<CategoryItemEntity> data)?  categoryLoaded,TResult? Function( Failure failure)?  categoryLoadFailure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CategoryLoaded() when categoryLoaded != null:
return categoryLoaded(_that.data);case _CategoryLoadFailure() when categoryLoadFailure != null:
return categoryLoadFailure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CategoryState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState.initial()';
}


}




/// @nodoc


class _Loading implements CategoryState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState.loading()';
}


}




/// @nodoc


class _CategoryLoaded implements CategoryState {
  const _CategoryLoaded({required final  List<CategoryItemEntity> data}): _data = data;
  

 final  List<CategoryItemEntity> _data;
 List<CategoryItemEntity> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}


/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryLoadedCopyWith<_CategoryLoaded> get copyWith => __$CategoryLoadedCopyWithImpl<_CategoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryLoaded&&const DeepCollectionEquality().equals(other._data, _data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'CategoryState.categoryLoaded(data: $data)';
}


}

/// @nodoc
abstract mixin class _$CategoryLoadedCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory _$CategoryLoadedCopyWith(_CategoryLoaded value, $Res Function(_CategoryLoaded) _then) = __$CategoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<CategoryItemEntity> data
});




}
/// @nodoc
class __$CategoryLoadedCopyWithImpl<$Res>
    implements _$CategoryLoadedCopyWith<$Res> {
  __$CategoryLoadedCopyWithImpl(this._self, this._then);

  final _CategoryLoaded _self;
  final $Res Function(_CategoryLoaded) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_CategoryLoaded(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<CategoryItemEntity>,
  ));
}


}

/// @nodoc


class _CategoryLoadFailure implements CategoryState {
  const _CategoryLoadFailure({required this.failure});
  

 final  Failure failure;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryLoadFailureCopyWith<_CategoryLoadFailure> get copyWith => __$CategoryLoadFailureCopyWithImpl<_CategoryLoadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryLoadFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'CategoryState.categoryLoadFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$CategoryLoadFailureCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory _$CategoryLoadFailureCopyWith(_CategoryLoadFailure value, $Res Function(_CategoryLoadFailure) _then) = __$CategoryLoadFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class __$CategoryLoadFailureCopyWithImpl<$Res>
    implements _$CategoryLoadFailureCopyWith<$Res> {
  __$CategoryLoadFailureCopyWithImpl(this._self, this._then);

  final _CategoryLoadFailure _self;
  final $Res Function(_CategoryLoadFailure) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_CategoryLoadFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
