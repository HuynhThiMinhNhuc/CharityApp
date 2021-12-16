import 'package:charityapp/core/helper/uint8list_converter.dart';
import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile extends UserInfor{
  int numberPost;
  int numberFollower;
  int numberFollowing;

  UserProfile({required name, 
      required avatar,
      description,
      birthDayString,
      gender = Genders.Undefined,
      this.numberFollower = 0,
      this.numberFollowing = 0,
      this.numberPost = 0,
  }) : super(name: name, avatar: avatar, description: description, birthDayString: birthDayString, gender: gender,);

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

}