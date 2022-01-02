import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase  {
  var db, collection, initialized;

  MongoDatabase(){
    initialized = init();
  }

  init() async {
    db = await Db.create("mongodb+srv://temp:temp@cluster0.mj7th.mongodb.net/db?retryWrites=true&w=majority");
    await db.open();
    collection = await db.collection("users");
  }

  Future<dynamic> findOne(dynamic query) async {
    await initialized;
    return await collection.findOne(query);
  }

  Future<dynamic> insertOne(dynamic query) async {
    await initialized;
    await collection.insertOne(query);
  }
}