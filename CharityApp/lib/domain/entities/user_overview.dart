import 'package:charityapp/domain/entities/base_user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_overview.g.dart';

@CopyWith()
@JsonSerializable()
class UserOverview extends BaseUser {
  String? avatarUri;
  String? address;
  
  UserOverview({
    required String name,
    this.avatarUri,
    String? id,
    this.address,
  }) : super(name: name, id: id);

  // factory UserOverview.fromJson(Map<String, dynamic> json) => _$UserOverviewFromJson(json);
  // Map<String, dynamic> toJson() => _$UserOverviewToJson(this);

  factory UserOverview.fromJson(Map<String, dynamic> json) => UserOverview(
        name: json['name'],
        avatarUri: json['avatarUri'] as String?,
        address: json['address']
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'avatarUri': this.avatarUri?.toString(),
        'address':this.address
      };
}
