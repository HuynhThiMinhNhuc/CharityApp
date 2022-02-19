// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_infor.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfEventInfor.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfEventInfor.copyWith.fieldName(...)`
class _EventInforCWProxy {
  final EventInfor _value;

  const _EventInforCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `EventInfor(...).copyWithNull(...)` to set certain fields to `null`. Prefer `EventInfor(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventInfor(...).copyWith(id: 12, name: "My name")
  /// ````
  EventInfor call({
    String? avatarUri,
    String? backgroundUri,
    String? creatorId,
    String? description,
    String? id,
    LatLng? locationGeo,
    String? locationText,
    String? name,
    int? numberMember,
    int? numberPost,
    List<TagEvent>? tags,
    DateTime? timeCreate,
    DateTime? timeStart,
  }) {
    return EventInfor(
      avatarUri: avatarUri ?? _value.avatarUri,
      backgroundUri: backgroundUri ?? _value.backgroundUri,
      creatorId: creatorId ?? _value.creatorId,
      description: description ?? _value.description,
      id: id ?? _value.id,
      locationGeo: locationGeo ?? _value.locationGeo,
      locationText: locationText ?? _value.locationText,
      name: name ?? _value.name,
      numberMember: numberMember ?? _value.numberMember,
      numberPost: numberPost ?? _value.numberPost,
      tags: tags ?? _value.tags,
      timeCreate: timeCreate ?? _value.timeCreate,
      timeStart: timeStart ?? _value.timeStart,
    );
  }

  EventInfor avatarUri(String? avatarUri) => avatarUri == null
      ? _value._copyWithNull(avatarUri: true)
      : this(avatarUri: avatarUri);

  EventInfor backgroundUri(String? backgroundUri) => backgroundUri == null
      ? _value._copyWithNull(backgroundUri: true)
      : this(backgroundUri: backgroundUri);

  EventInfor description(String? description) => description == null
      ? _value._copyWithNull(description: true)
      : this(description: description);

  EventInfor id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  EventInfor locationGeo(LatLng? locationGeo) => locationGeo == null
      ? _value._copyWithNull(locationGeo: true)
      : this(locationGeo: locationGeo);

  EventInfor locationText(String? locationText) => locationText == null
      ? _value._copyWithNull(locationText: true)
      : this(locationText: locationText);

  EventInfor timeCreate(DateTime? timeCreate) => timeCreate == null
      ? _value._copyWithNull(timeCreate: true)
      : this(timeCreate: timeCreate);

  EventInfor timeStart(DateTime? timeStart) => timeStart == null
      ? _value._copyWithNull(timeStart: true)
      : this(timeStart: timeStart);

  EventInfor creatorId(String creatorId) => this(creatorId: creatorId);

  EventInfor name(String name) => this(name: name);

  EventInfor numberMember(int numberMember) => this(numberMember: numberMember);

  EventInfor numberPost(int numberPost) => this(numberPost: numberPost);

  EventInfor tags(List<TagEvent> tags) => this(tags: tags);
}

extension EventInforCopyWith on EventInfor {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass EventInfor extends EventOverview.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass EventInfor extends EventOverview.name.copyWith.fieldName(...)`
  _EventInforCWProxy get copyWith => _EventInforCWProxy(this);

  EventInfor _copyWithNull({
    bool avatarUri = false,
    bool backgroundUri = false,
    bool description = false,
    bool id = false,
    bool locationGeo = false,
    bool locationText = false,
    bool timeCreate = false,
    bool timeStart = false,
  }) {
    return EventInfor(
      avatarUri: avatarUri == true ? null : this.avatarUri,
      backgroundUri: backgroundUri == true ? null : this.backgroundUri,
      creatorId: creatorId,
      description: description == true ? null : this.description,
      id: id == true ? null : this.id,
      locationGeo: locationGeo == true ? null : this.locationGeo,
      locationText: locationText == true ? null : this.locationText,
      name: name,
      numberMember: numberMember,
      numberPost: numberPost,
      tags: tags,
      timeCreate: timeCreate == true ? null : this.timeCreate,
      timeStart: timeStart == true ? null : this.timeStart,
    );
  }
}
