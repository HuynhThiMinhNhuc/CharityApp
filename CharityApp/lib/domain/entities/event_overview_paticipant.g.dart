// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_overview_paticipant.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfEventOverviewPaticipants.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfEventOverviewPaticipants.copyWith.fieldName(...)`
class _EventOverviewPaticipantsCWProxy {
  final EventOverviewPaticipants _value;

  const _EventOverviewPaticipantsCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `EventOverviewPaticipants(...).copyWithNull(...)` to set certain fields to `null`. Prefer `EventOverviewPaticipants(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EventOverviewPaticipants(...).copyWith(id: 12, name: "My name")
  /// ````
  EventOverviewPaticipants call({
    String? backgroundUri,
    String? creatorId,
    String? id,
    String? name,
    int? number,
    List<String?>? paticipantsUri,
    DateTime? timeCreate,
    DateTime? timeStart,
  }) {
    return EventOverviewPaticipants(
      backgroundUri: backgroundUri ?? _value.backgroundUri,
      creatorId: creatorId ?? _value.creatorId,
      id: id ?? _value.id,
      name: name ?? _value.name,
      number: number ?? _value.number,
      paticipantsUri: paticipantsUri ?? _value.paticipantsUri,
      timeCreate: timeCreate ?? _value.timeCreate,
      timeStart: timeStart ?? _value.timeStart,
    );
  }

  EventOverviewPaticipants backgroundUri(String? backgroundUri) =>
      backgroundUri == null
          ? _value._copyWithNull(backgroundUri: true)
          : this(backgroundUri: backgroundUri);

  EventOverviewPaticipants id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  EventOverviewPaticipants paticipantsUri(List<String?>? paticipantsUri) =>
      paticipantsUri == null
          ? _value._copyWithNull(paticipantsUri: true)
          : this(paticipantsUri: paticipantsUri);

  EventOverviewPaticipants timeCreate(DateTime? timeCreate) =>
      timeCreate == null
          ? _value._copyWithNull(timeCreate: true)
          : this(timeCreate: timeCreate);

  EventOverviewPaticipants timeStart(DateTime? timeStart) => timeStart == null
      ? _value._copyWithNull(timeStart: true)
      : this(timeStart: timeStart);

  EventOverviewPaticipants creatorId(String creatorId) =>
      this(creatorId: creatorId);

  EventOverviewPaticipants name(String name) => this(name: name);

  EventOverviewPaticipants number(int number) => this(number: number);
}

extension EventOverviewPaticipantsCopyWith on EventOverviewPaticipants {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass EventOverviewPaticipants extends BaseEvent.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass EventOverviewPaticipants extends BaseEvent.name.copyWith.fieldName(...)`
  _EventOverviewPaticipantsCWProxy get copyWith =>
      _EventOverviewPaticipantsCWProxy(this);

  EventOverviewPaticipants _copyWithNull({
    bool backgroundUri = false,
    bool id = false,
    bool paticipantsUri = false,
    bool timeCreate = false,
    bool timeStart = false,
  }) {
    return EventOverviewPaticipants(
      backgroundUri: backgroundUri == true ? null : this.backgroundUri,
      creatorId: creatorId,
      id: id == true ? null : this.id,
      name: name,
      number: number,
      paticipantsUri: paticipantsUri == true ? null : this.paticipantsUri,
      timeCreate: timeCreate == true ? null : this.timeCreate,
      timeStart: timeStart == true ? null : this.timeStart,
    );
  }
}
