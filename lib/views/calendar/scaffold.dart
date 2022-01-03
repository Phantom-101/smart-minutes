import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:meeting_minutes/views/invitation/invitation_list/scaffold.dart';
import 'package:meeting_minutes/views/teams/team_list/scaffold.dart';

import 'view.dart';

class CalendarScaffold extends StatelessWidget {
  final List<Recording> recordings;

  const CalendarScaffold(this.recordings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Calendar(recordings),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              Expanded(
                flex: 1,
                child: TextButton.icon(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.home),
                  label: const Text("Home"),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TeamListScaffold([Team("1","Team 1", "wojaad")])));
                  },
                  icon:const Icon(Icons.people),
                  label:const Text("Teams"),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => InvitationListScaffold([Team("1","Team 1", "wojaad")])));
                  },
                  icon:const Icon(Icons.notifications),
                  label:const Text("Notifications"),
                ),
              ),
            ],
          ),
    ));
  }
}