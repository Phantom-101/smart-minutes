import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:meeting_minutes/views/calendar/view.dart';
import 'package:meeting_minutes/views/home/view.dart';
import 'package:meeting_minutes/views/teams/create_team/scaffold.dart';
import 'package:meeting_minutes/views/teams/team_list/view.dart';
import 'package:provider/provider.dart';

class DashboardScaffold extends StatefulWidget {
  const DashboardScaffold({Key? key}) : super(key: key);

  @override
  State<DashboardScaffold> createState() => _DashboardScaffoldState();
}

class _DashboardScaffoldState extends State<DashboardScaffold> {
  int _tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Teams'),
        ],
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
      body: [
        FutureBuilder(
          future: context.read<Database>().getUserRecordings(context.read<User>()),
          builder: (context, AsyncSnapshot<List<Recording>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Calendar(snapshot.data!);
              }
              return const Calendar([]);
            }
            return const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Loading'),
              ),
            );
          },
        ),
        const Home(),
        ListView(
          shrinkWrap: true,
          children: [
            FutureBuilder(
              future: context.read<Database>().getTeams(context.read<User>()),
              builder: (context, AsyncSnapshot<List<Team>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return TeamList(snapshot.data!);
                  }
                  return const TeamList([]);
                }
                return const Card(
                  child: ListTile(
                    title: Text('Loading'),
                  ),
                );
              },
            ),
            Card(
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTeamScaffold()));
                },
                child: const Text('Create Team'),
              ),
            ),
          ],
        ),
      ][_tabIndex],
    );
  }
}