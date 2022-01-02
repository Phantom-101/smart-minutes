import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return FutureBuilder(
      future: context.read<StorageUtil>().getString("token"),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return FutureBuilder(
            future: context.read<MongoDatabase>().findOne({"token":snapshot.data}),
            builder: (context, result){
              if (result.hasData){
                return const HomeLoggedIn();
              } else {return const HomeLoggedOut();}
            }
          ); 
        }
        return const CircularProgressIndicator();
      }
    );
  }
}