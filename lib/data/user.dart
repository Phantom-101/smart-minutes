import 'package:mongo_dart/mongo_dart.dart';
class User {
  final ObjectId id;
  final String email;
  final String token;

  User(this.id, this.email, this.token);
}