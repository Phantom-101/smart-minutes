import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "NAME",
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height:10),
          const Text(
            "Aditya Mittal",
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height:30),
          const Text(
            "# TEAMS",
            style: TextStyle(
              color: Colors.grey,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height:10),
          const Text(
            "8",
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height:30),
          Row(
            children: <Widget>[
              Icon(
                Icons.email,
                color: Colors.grey[400],
              ),
              const SizedBox(width: 10),
              Text(
                "toadityamittal@gmail.com",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}