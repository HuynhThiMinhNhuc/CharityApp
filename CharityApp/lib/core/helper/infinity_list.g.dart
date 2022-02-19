// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infinity_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfInfinityList.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfInfinityList.copyWith.fieldName(...)`
class _InfinityListCWProxy<T> {
  final InfinityList<T> _value;

  const _InfinityListCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `InfinityList<T>(...).copyWithNull(...)` to set certain fields to `null`. Prefer `InfinityList<T>(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InfinityList<T>(...).copyWith(id: 12, name: "My name")
  /// ````
  InfinityList<T> call({
    bool? isFull,
    List<T>? items,
    InfinityListStatus? status,
  }) {
    return InfinityList<T>(
      isFull: isFull ?? _value.isFull,
      items: items ?? _value.items,
      status: status ?? _value.status,
    );
  }

  InfinityList<T> isFull(bool isFull) => this(isFull: isFull);

  InfinityList<T> items(List<T> items) => this(items: items);

  InfinityList<T> status(InfinityListStatus status) => this(status: status);
}

extension InfinityListCopyWith<T> on InfinityList<T> {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass InfinityList<T> extends Equatable.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass InfinityList<T> extends Equatable.name.copyWith.fieldName(...)`
  _InfinityListCWProxy<T> get copyWith => _InfinityListCWProxy<T>(this);
}
