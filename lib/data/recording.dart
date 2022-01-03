import 'package:meeting_minutes/data/conversation_job.dart';

class Recording {
  final String id;
  final ConversationJob job;
  final DateTime date;

  Recording(this.id, this.job, this.date);
}