import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/conversation_job.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:meeting_minutes/views/calendar/view.dart';
import 'package:meeting_minutes/views/profile/view.dart';
import 'package:meeting_minutes/views/teams/team_list/view.dart';

class HomeLoggedIn extends StatefulWidget {
  const HomeLoggedIn({Key? key}) : super(key: key);

  @override
  State<HomeLoggedIn> createState() => _HomeLoggedInState();
}

class _HomeLoggedInState extends State<HomeLoggedIn> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome to Your Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Teams'),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: [
        Calendar([
          Recording('1', ConversationJob('1', '1'), DateTime.now()),
          Recording('2', ConversationJob('2', '2'), DateTime.now()),
          Recording('3', ConversationJob('3', '3'), DateTime.now()),
        ]),
        Profile(),
        TeamList([
          Team('1', 'Team 1', 'Description'),
          Team('2', 'Team 2', 'Description'),
          Team('3', 'Team 3', 'Description'),
          Team('4', 'Team 4', 'Description'),
          Team('5', 'Team 5', 'Description'),
        ]),
      ][_index],
    );
  }
}

