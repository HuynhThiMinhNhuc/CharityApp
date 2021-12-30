import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@CopyWith()
@JsonSerializable()
class UserProfile extends UserInfor {
  int numberPost;
  int numberFollower;
  int numberFollowing;
  String phone;
  String email;

  UserProfile({
    required name,
    required avatarUri,
    description,
    birthDayString,
    gender = Genders.Undefined,
    this.numberFollower = 0,
    this.numberFollowing = 0,
    this.numberPost = 0,
    required this.phone,
    required this.email,
    String? id,
  }) : super(
            name: name,
            avatarUri: avatarUri,
            description: description,
            birthDayString: birthDayString,
            gender: gender,
            id: id);

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
