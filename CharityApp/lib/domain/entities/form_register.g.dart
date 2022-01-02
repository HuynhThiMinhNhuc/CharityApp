// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_register.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension FormRegisterCopyWith on FormRegister {
  FormRegister copyWith({
    String? creatorId,
    String? email,
    String? eventId,
    String? id,
    String? name,
    String? phone,
    List<String>? questions,
    DateTime? timeCreate,
  }) {
    return FormRegister(
      creatorId: creatorId ?? this.creatorId,
      email: email ?? this.email,
      eventId: eventId ?? this.eventId,
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      questions: questions ?? this.questions,
      timeCreate: timeCreate ?? this.timeCreate,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormRegister _$FormRegisterFromJson(Map<String, dynamic> json) => FormRegister(
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      id: json['id'] as String?,
      creatorId: json['creatorId'] as String,
      eventId: json['eventId'] as String,
      timeCreate: DateTime.parse(json['timeCreate'] as String),
    );

Map<String, dynamic> _$FormRegisterToJson(FormRegister instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'creatorId': instance.creatorId,
      'eventId': instance.eventId,
      'timeCreate': instance.timeCreate.toIso8601String(),
      'questions': instance.questions,
    };
