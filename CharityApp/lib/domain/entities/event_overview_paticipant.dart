import 'package:charityapp/domain/entities/base_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'event_overview_paticipant.g.dart';

@CopyWith()
class EventOverviewPaticipants extends BaseEvent {
  final int number;
  final DateTime? timeStart;
  late List<String?> paticipantsUri;
  final String? backgroundUri;
  EventOverviewPaticipants({
    List<String?>? paticipantsUri,
    String? id,
    required String name,
    required String creatorId,
    required this.number,
    required this.timeStart,
    required this.backgroundUri,
    DateTime? timeCreate,
  }) : super(name: name, timeCreate: timeCreate, creatorId: creatorId) {
    if (paticipantsUri != null)
      this.paticipantsUri = paticipantsUri;
    else
      this.paticipantsUri = [];
  }

  factory EventOverviewPaticipants.fromJson(Map<String, dynamic> json) =>
      EventOverviewPaticipants(
        name: json['name'] as String,
        creatorId: json['creatorId'] as String,
        number: json['numberMember'] as int? ?? 0,
        timeStart: json['timeStart'] == null
            ? null
            : (json['timeStart'] as Timestamp).toDate(),
        backgroundUri: json['backgroundUri'] as String?,
        timeCreate: json['timeCreate'] == null
            ? null
            : (json['timeCreate'] as Timestamp).toDate(),
      );

  // factory PostOverview.fromJson(Map<String, dynamic> json) => _$PostOverviewFromJson(json);
  // Map<String, dynamic> toJson() => _$PostOverviewToJson(this);
}
