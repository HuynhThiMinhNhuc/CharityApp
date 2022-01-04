// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_infor.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension EventInforCopyWith on EventInfor {
  EventInfor copyWith({
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
      avatarUri: avatarUri ?? this.avatarUri,
      backgroundUri: backgroundUri ?? this.backgroundUri,
      creatorId: creatorId ?? this.creatorId,
      description: description ?? this.description,
      id: id ?? this.id,
      locationGeo: locationGeo ?? this.locationGeo,
      locationText: locationText ?? this.locationText,
      name: name ?? this.name,
      numberMember: numberMember ?? this.numberMember,
      numberPost: numberPost ?? this.numberPost,
      tags: tags ?? this.tags,
      timeCreate: timeCreate ?? this.timeCreate,
      timeStart: timeStart ?? this.timeStart,
    );
  }
}
