import 'package:meeting_minutes/data/conversation_job.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database  {
  late Db db;

  late Future<void> initialized;

  Database(){
    initialized = init();
  }

  Future<void> init() async {
    db = await Db.create("mongodb+srv://temp:temp@cluster0.mj7th.mongodb.net/db?retryWrites=true&w=majority");
    await db.open();
    return;
  }

  Future<bool> emailExists(String email) async {
    await initialized;

    DbCollection users = db.collection('users');

    return await users.findOne(where.eq('email', email)) != null;
  }

  Future<bool> verifyToken(User user, String token) async {
    await initialized;

    DbCollection users = db.collection('users');

    var doc = await users.findOne(where.eq('token', token));
    if (doc == null) return false;
    user.id = doc['_id'];
    user.email = doc['email'];
    user.password = doc['password'];
    return true;
  }

  Future<bool> verifyEmailAndPassword(User user, String email, String password) async {
    await initialized;

    DbCollection users = db.collection('users');

    var doc = await users.findOne(where.eq('email', email).and(where.eq('password', password)));
    if (doc == null) return false;
    user.id = doc['_id'];
    user.email = doc['email'];
    user.password = doc['password'];
    return true;
  }

  Future<void> createUser(User user, String email, String password) async {
    await initialized;
    WriteResult result = await db.collection('users').insertOne({'email': email, 'password': password});
    user.id = result.id;
    user.email = email;
    user.password = password;
  }

  Future<void> changeUserToken(User user, String token) async {
    await initialized;

    DbCollection users = db.collection('users');

    users.updateOne(where.eq('_id', user.id), modify.set('token', token));
  }

  Future<Recording?> getRecording(String id) async {
    await initialized;

    DbCollection recordings = db.collection('recordings');

    var oid = ObjectId.parse(id);
    var doc = await recordings.findOne(where.eq('_id', oid));
    return doc == null ? null : Recording(oid, ConversationJob(doc['conversationId'], doc['jobId']), doc['date']);
  }

  Future<List<Recording>> getRecordings(Team team) async {
    await initialized;

    DbCollection teams = db.collection('teams');

    List<dynamic> ids = (await teams.findOne(where.eq('_id', team.id)))!['recordingIds'] ?? [];

    List<Recording> ret = [];
    for(ObjectId id in ids) {
      Recording? recording = await getRecording(id.$oid);
      if (recording != null) {
        ret.add(recording);
      }
    }

    return ret;
  }

  Future<List<Recording>> getUserRecordings(User user) async {
    await initialized;

    List<Team> teams = await getTeams(user);

    List<Recording> ret = [];
    for (Team team in teams) {
      ret.addAll(await getRecordings(team));
    }
    return ret;
  }

  Future<Recording> addRecording(Team team, ConversationJob job) async {
    await initialized;

    DbCollection recordings = db.collection('recordings');

    DateTime date = DateTime.now();
    WriteResult result = await recordings.insertOne({
      'conversationId': job.conversationId,
      'jobId': job.jobId,
      'date': date,
    });

    DbCollection teams = db.collection('teams');

    await teams.updateOne(where.eq('_id', team.id), modify.addToSet('recordingIds', result.id));

    return Recording(result.id, job, date);
  }

  Future<Team?> getTeam(String id) async {
    await initialized;

    DbCollection teams = db.collection('teams');

    var oid = ObjectId.parse(id);
    var doc = await teams.findOne(where.eq('_id', oid));
    return doc == null ? null : Team(oid, doc['name'], doc['description']);
  }

  Future<List<Team>> getTeams(User user) async {
    await initialized;

    DbCollection users = db.collection('users');

    List<dynamic> ids = (await users.findOne(where.eq('_id', user.id)))!['teamIds'] ?? [];

    List<Team> ret = [];
    for(ObjectId id in ids) {
      Team? team = await getTeam(id.$oid);
      if (team != null) {
        ret.add(team);
      }
    }

    return ret;
  }

  Future<Team> addTeam(User user, String name, String description) async {
    await initialized;

    DbCollection teams = db.collection('teams');

    WriteResult result = await teams.insertOne({
      'name': name,
      'description': description,
    });

    DbCollection users = db.collection('users');

    await users.updateOne(where.eq('_id', user.id), modify.addToSet('teamIds', result.id));

    return Team(result.id, name, description);
  }
}