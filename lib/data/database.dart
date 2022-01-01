import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase  {
  static var db, collection;

  static connect() async {
    db = await Db.create("mongodb+srv://temp:temp@cluster0.mj7th.mongodb.net/db");
    await db.open();
    collection = db.collection("users");
  }

}