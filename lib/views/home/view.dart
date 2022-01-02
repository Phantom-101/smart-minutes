import 'package:flutter/cupertino.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:meeting_minutes/views/home/logged_in/view.dart';
import 'package:meeting_minutes/views/home/logged_out/view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    User? user = context.read<User?>();
    if (user == null) {
      return const HomeLoggedOut();
    }
    return const HomeLoggedIn();
  }
}