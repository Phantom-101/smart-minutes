import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:meeting_minutes/utils/shared_preferences.dart';
import 'package:meeting_minutes/views/calendar/scaffold.dart';
import 'package:meeting_minutes/views/calendar/view.dart';
import 'package:meeting_minutes/views/home/logged_in/view.dart';
import 'package:meeting_minutes/views/home/logged_out/view.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const HomeLoggedOut();
  }
}