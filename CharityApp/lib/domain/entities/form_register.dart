import 'package:charityapp/domain/entities/base_object.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_register.g.dart';

@CopyWith()
@JsonSerializable()
class FormRegister extends BaseObject {
  String name;
  String phone;
  String email;
  String creatorId;
  String eventId;
  DateTime timeCreate;
  List<String> questions;

  FormRegister({
    required this.name,
    required this.phone,
    required this.email,
    this.questions = const [],
    String? id,
    required this.creatorId,
    required this.eventId,
    required this.timeCreate,
  }) : super(id: id);

  Map<String, dynamic> toJson() => _$FormRegisterToJson(this);
  factory FormRegister.fromJson(Map<String, dynamic> json) =>
      _$FormRegisterFromJson(json);
}
