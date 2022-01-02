import 'package:mongo_dart/mongo_dart.dart';
class User {
  final ObjectId id;
  final String email;
  final String password;
  final String token;

<<<<<<< HEAD
  User(this.id, this.email, this.password, this.token);
=======
  User(this.id, this.email, this.token);
>>>>>>> 72aca7f72437c690a5a35f0dda90d46e65f0b42e
}