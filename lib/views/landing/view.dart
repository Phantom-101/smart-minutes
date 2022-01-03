import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:meeting_minutes/data/database.dart';
import 'package:meeting_minutes/data/user.dart';
import 'package:meeting_minutes/utils/shared_preferences.dart';
import 'package:meeting_minutes/views/dashboard/scaffold.dart';
import 'package:meeting_minutes/views/login/scaffold.dart';
import 'package:meeting_minutes/views/register/scaffold.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<StorageUtil>().getString("token"),
      builder: (context, AsyncSnapshot<String> tokenSnapshot){
        if (tokenSnapshot.hasData){
          return FutureBuilder(
            future: context.read<Database>().verifyToken(context.read<User>(), tokenSnapshot.data!),
            builder: (context, AsyncSnapshot<bool> existsSnapshot){
              if (existsSnapshot.hasData){
                if (existsSnapshot.data!) {
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScaffold()));
                  });
                  return const Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Logging you in...'),
                      ),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: Text('You are currently logged out.')),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScaffold()));
                      },
                      child: const Text('Log In'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScaffold()));
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                );
              }
              return const Center(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Validating token...'),
                  ),
                ),
              );
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}