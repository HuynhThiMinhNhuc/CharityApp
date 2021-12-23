import 'package:charityapp/domain/entities/base_post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'post_overview.g.dart';

@CopyWith()
class PostOverview extends BasePost {
  final int number;
  final DateTime timeStart;
  final List<String> paticipantsUri;
  PostOverview({
    required this.paticipantsUri,
    String? id,
    required String title,
    String? eventId,
    UserOverview? creator,
    required this.number,
    required this.timeStart,
  }) : super(
          title: title,
          id: id,
          creator: creator,
        );

    // factory PostOverview.fromJson(Map<String, dynamic> json) => _$PostOverviewFromJson(json);
  // Map<String, dynamic> toJson() => _$PostOverviewToJson(this);
}
