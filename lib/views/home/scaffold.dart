import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/utils/shared_preferences.dart';
import 'package:meeting_minutes/views/calendar/scaffold.dart';
import 'package:provider/provider.dart';

import 'view.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<StorageUtil>().getString("token"),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return FutureBuilder(
            future: context.read<MongoDatabase>().findOne({"token":snapshot.data}),
            builder: (context, result){
              if (result.hasData){
                return CalendarScaffold([]);
              } else {return Scaffold(
                appBar: AppBar(title: const Text('Home'),),
                body: const Home(),
                );
              }
            }
          ); 
        }
        return const CircularProgressIndicator();
      }
    );

  }
}