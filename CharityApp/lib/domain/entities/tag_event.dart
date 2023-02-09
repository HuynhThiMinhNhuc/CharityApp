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
        name: json['vn'] as String,
      );

  Map<String, dynamic> _$TagEventToJson(TagEvent instance) => <String, dynamic>{
        'vn': instance.name,
      };
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != this.runtimeType) return false;
    return other is TagEvent && other.id == this.id;
  }
}
