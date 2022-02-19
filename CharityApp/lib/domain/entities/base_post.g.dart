// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_post.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfBasePost.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfBasePost.copyWith.fieldName(...)`
class _BasePostCWProxy {
  final BasePost _value;

  const _BasePostCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `BasePost(...).copyWithNull(...)` to set certain fields to `null`. Prefer `BasePost(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BasePost(...).copyWith(id: 12, name: "My name")
  /// ````
  BasePost call({
    UserOverview? creator,
    String? eventId,
    String? id,
    DateTime? timeCreate,
    String? title,
  }) {
    return BasePost(
      creator: creator ?? _value.creator,
      eventId: eventId ?? _value.eventId,
      id: id ?? _value.id,
      timeCreate: timeCreate ?? _value.timeCreate,
      title: title ?? _value.title,
    );
  }

  BasePost creator(UserOverview? creator) => creator == null
      ? _value._copyWithNull(creator: true)
      : this(creator: creator);

  BasePost eventId(String? eventId) => eventId == null
      ? _value._copyWithNull(eventId: true)
      : this(eventId: eventId);

  BasePost id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  BasePost timeCreate(DateTime? timeCreate) => timeCreate == null
      ? _value._copyWithNull(timeCreate: true)
      : this(timeCreate: timeCreate);

  BasePost title(String title) => this(title: title);
}

extension BasePostCopyWith on BasePost {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass BasePost extends BaseObject implements CreatableObject<UserOverview>.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass BasePost extends BaseObject implements CreatableObject<UserOverview>.name.copyWith.fieldName(...)`
  _BasePostCWProxy get copyWith => _BasePostCWProxy(this);

  BasePost _copyWithNull({
    bool creator = false,
    bool eventId = false,
    bool id = false,
    bool timeCreate = false,
  }) {
    return BasePost(
      creator: creator == true ? null : this.creator,
      eventId: eventId == true ? null : this.eventId,
      id: id == true ? null : this.id,
      timeCreate: timeCreate == true ? null : this.timeCreate,
      title: title,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePost _$BasePostFromJson(Map<String, dynamic> json) => BasePost(
      title: json['title'] as String,
      creator: json['creator'] == null
          ? null
          : UserOverview.fromJson(json['creator'] as Map<String, dynamic>),
      eventId: json['eventId'] as String?,
      id: json['id'] as String?,
      timeCreate: json['timeCreate'] == null
          ? null
          : DateTime.parse(json['timeCreate'] as String),
    );

Map<String, dynamic> _$BasePostToJson(BasePost instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'eventId': instance.eventId,
      'creator': instance.creator,
      'timeCreate': instance.timeCreate?.toIso8601String(),
    };
