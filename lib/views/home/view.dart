import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/data/team.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Card(
          child: ListTile(
            title: Text(context.read<User>().email ?? 'Unknown'),
            subtitle: FutureBuilder(
              future: context.read<Database>().getTeams(context.read<User>()),
              builder: (context, AsyncSnapshot<List<Team>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Text('In ${snapshot.data!.length.toString()} teams');
                  }
                  return const Text('Unknown # of teams');
                }
                return const Text('Loading');
              },
            ),
          ),
        ),
      ],
    );
  }
}