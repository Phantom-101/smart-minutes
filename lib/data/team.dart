import 'package:mongo_dart/mongo_dart.dart';

class Team {
  final ObjectId id;
  final String name;
  final String description;

  Team(this.id, this.name, this.description);
}