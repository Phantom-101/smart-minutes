import 'package:meeting_minutes/data/conversation_job.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Recording {
  final ObjectId id;
  final ConversationJob job;
  final DateTime date;

  Recording(this.id, this.job, this.date);
}