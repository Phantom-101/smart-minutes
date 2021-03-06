import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dart_json_mapper_mobx/dart_json_mapper_mobx.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:meeting_minutes/main.mapper.g.dart';
import 'package:meeting_minutes/utils/shared_preferences.dart';
import 'package:meeting_minutes/views/landing/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:meeting_minutes/data/database.dart';
import 'data/symbl_api.dart';
import 'data/user.dart';

void main() {
  initializeJsonMapper();
  JsonMapper().useAdapter(mobXAdapter);

  runApp(
    Material(
      child: MultiProvider(
        providers: [
          Provider(create: (_) => Logger(printer: SimplePrinter(colors: false))),
          Provider(create: (_) => Database()),
          Provider(create: (_) => StorageUtil()),
          Provider(create: (_) => SymblApi()),
          Provider(create: (_) => User()),
        ],
        builder: (_, __) => const MyApp(),
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Minutes',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LandingScaffold(),
    );
  }
}
