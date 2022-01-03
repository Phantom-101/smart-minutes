import 'package:meeting_minutes/data/conversation_job.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase  {
  late Db db;

  late Future<void> initialized;

  MongoDatabase(){
    initialized = init();
  }

  Future<void> init() async {
    db = await Db.create("mongodb+srv://temp:temp@cluster0.mj7th.mongodb.net/db?retryWrites=true&w=majority");
    await db.open();
    return;
  }

  Future<bool> emailExists(String email) async {
    await initialized;

    DbCollection col = db.collection('users');

    return await col.findOne(where.eq('email', email)) != null;
  }

  Future<bool> tokenExists(String token) async {
    await initialized;

    DbCollection col = db.collection('users');

    return await col.findOne(where.eq('token', token)) != null;
  }

  Future<bool> verifyEmailAndPassword(String email, String password) async {
    await initialized;

    DbCollection col = db.collection('users');

    return await col.findOne(where.eq('email', email).and(where.eq('password', password))) != null;
  }

  Future<void> createUser(String email, String password) async {
    await initialized;

    DbCollection col = db.collection('users');

    await col.insertOne({'email': email, 'password': password});

    return;
  }

  Future<void> changeUserToken(String email, String token) async {
    await initialized;

    DbCollection col = db.collection('users');

    col.updateOne(where.eq('email', email), modify.set('token', token));
  }

  Future<Recording> addRecording(ConversationJob job) async {
    await initialized;

    DbCollection col = db.collection('recordings');

    DateTime date = DateTime.now();
    WriteResult result = await col.insertOne({
      'job': {
        'conversationId': job.conversationId,
        'jobId': job.jobId,
      },
      'date': date,
    });

    return Recording(result.id, job, date);
  }
}