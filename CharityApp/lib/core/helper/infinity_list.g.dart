// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infinity_list.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfInfinityListController.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfInfinityListController.copyWith.fieldName(...)`
class _InfinityListControllerCWProxy<T> {
  final InfinityListController<T> _value;

  const _InfinityListControllerCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `InfinityListController<T>(...).copyWithNull(...)` to set certain fields to `null`. Prefer `InfinityListController<T>(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InfinityListController<T>(...).copyWith(id: 12, name: "My name")
  /// ````
  InfinityListController<T> call({
    List<T>? items,
    InfinityListStatus? status,
  }) {
    return InfinityListController<T>(
      items: items ?? _value.items,
      status: status ?? _value.status,
    );
  }

  InfinityListController<T> items(List<T> items) => this(items: items);

  InfinityListController<T> status(InfinityListStatus status) =>
      this(status: status);
}

extension InfinityListControllerCopyWith<T> on InfinityListController<T> {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass InfinityListController<T> extends Equatable.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass InfinityListController<T> extends Equatable.name.copyWith.fieldName(...)`
  _InfinityListControllerCWProxy<T> get copyWith =>
      _InfinityListControllerCWProxy<T>(this);
}
