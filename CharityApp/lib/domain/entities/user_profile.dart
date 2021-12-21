import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile extends UserInfor{
  int numberPost;
  int numberFollower;
  int numberFollowing;

  UserProfile({required name, 
//<<<<<<< Updated upstream
      required avatarUri,
// =======
//      // avatar,
// >>>>>>> Stashed changes
      description,
      birthDayString,
      gender = Genders.Undefined,
      this.numberFollower = 0,
      this.numberFollowing = 0,
      this.numberPost = 0,
//<<<<<<< Updated upstream
  }) : super(name: name, avatarUri: avatarUri, description: description, birthDayString: birthDayString, gender: gender,);
// =======
//   }) : super(name: name, description: description, birthDayString: birthDayString, gender: gender,);
// >>>>>>> Stashed changes

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

}