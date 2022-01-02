import 'package:flutter/cupertino.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:meeting_minutes/utils/shared_preferences.dart';
import 'package:meeting_minutes/views/home/logged_in/view.dart';
import 'package:meeting_minutes/views/home/logged_out/view.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var token = context.read<StorageUtil>().getString("token");
    // print(token.toString());
    // print(context.read<MongoDatabase>().findOne({"token":"cow"}));
    // if (context.read<MongoDatabase>().findOne({"token":token})!=null) {
    //   return const HomeLoggedIn();
    // } 
    return const HomeLoggedOut();
  }
}