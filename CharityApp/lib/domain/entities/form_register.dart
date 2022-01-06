import 'package:charityapp/domain/entities/base_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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


  factory FormRegister.fromJson(Map<String, dynamic> json) => FormRegister(
        name: json['name'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        questions: (json['questions'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        creatorId: json['userId'] as String,
        eventId: json['eventId'] as String,
        timeCreate: (json['timeCreate'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'phone': this.phone,
        'email': this.email,
        'userId': this.creatorId,
        'eventId': this.eventId,
        'timeCreate': Timestamp.fromDate(this.timeCreate),
        'questions': this.questions,
      };
}
