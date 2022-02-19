// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_register.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

/// Proxy class for `CopyWith` functionality. This is a callable class and can be used as follows: `instanceOfFormRegister.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfFormRegister.copyWith.fieldName(...)`
class _FormRegisterCWProxy {
  final FormRegister _value;

  const _FormRegisterCWProxy(this._value);

  /// This function does not support nullification of optional types, all `null` values passed to this function will be ignored. For nullification, use `FormRegister(...).copyWithNull(...)` to set certain fields to `null`. Prefer `FormRegister(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FormRegister(...).copyWith(id: 12, name: "My name")
  /// ````
  FormRegister call({
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
      creatorId: creatorId ?? _value.creatorId,
      email: email ?? _value.email,
      eventId: eventId ?? _value.eventId,
      id: id ?? _value.id,
      name: name ?? _value.name,
      phone: phone ?? _value.phone,
      questions: questions ?? _value.questions,
      timeCreate: timeCreate ?? _value.timeCreate,
    );
  }

  FormRegister id(String? id) =>
      id == null ? _value._copyWithNull(id: true) : this(id: id);

  FormRegister creatorId(String creatorId) => this(creatorId: creatorId);

  FormRegister email(String email) => this(email: email);

  FormRegister eventId(String eventId) => this(eventId: eventId);

  FormRegister name(String name) => this(name: name);

  FormRegister phone(String phone) => this(phone: phone);

  FormRegister questions(List<String> questions) => this(questions: questions);

  FormRegister timeCreate(DateTime timeCreate) => this(timeCreate: timeCreate);
}

extension FormRegisterCopyWith on FormRegister {
  /// CopyWith feature provided by `copy_with_extension_gen` library. Returns a callable class and can be used as follows: `instanceOfclass FormRegister extends BaseObject.name.copyWith(...)`. Be aware that this kind of usage does not support nullification and all passed `null` values will be ignored. Prefer to copy the instance with a specific field change that handles nullification of fields correctly, e.g. like this:`instanceOfclass FormRegister extends BaseObject.name.copyWith.fieldName(...)`
  _FormRegisterCWProxy get copyWith => _FormRegisterCWProxy(this);

  FormRegister _copyWithNull({
    bool id = false,
  }) {
    return FormRegister(
      creatorId: creatorId,
      email: email,
      eventId: eventId,
      id: id == true ? null : this.id,
      name: name,
      phone: phone,
      questions: questions,
      timeCreate: timeCreate,
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
