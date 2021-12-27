import 'package:charityapp/domain/entities/base_object.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tag_event.g.dart';

@CopyWith()
@JsonSerializable()
class TagEvent extends BaseObject {
  final String name;
  TagEvent({required this.name, String? id}) : super(id: id);

  // factory TagEvent.fromJson(Map<String, dynamic> json) => _$TagEventFromJson(json);
  // Map<String, dynamic> tojSon() => _$TagEventToJson(this);

  factory TagEvent.fromJson(Map<String, dynamic> json) => TagEvent(
        name: json['name'] as String,
        id: json['id'] as String,
      );

  Map<String, dynamic> _$TagEventToJson(TagEvent instance) => <String, dynamic>{
        'id': instance.id,
        'name': instance.name,
      };
}
