import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class HomeLoggedIn extends StatelessWidget {
  const HomeLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Welcome to Your Profile"),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0,
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(40, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Center(
            //   child: CircleAvatar(
            //     backgroundImage: AssetImage("assets/pic.jpg"),
            //     radius: 70,
            //   ),
            // ),
            Divider(height: 60, color: Colors.grey[600],),
            Text(
              "NAME",
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2
              ),
            ),
            SizedBox(height:10),
            Text(
              "Aditya Mittal",
              style: TextStyle(
                  color: Colors.yellow[200],
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height:30),
            Text(
              "Number of Teams",
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2
              ),
            ),
            SizedBox(height:10),
            Text(
              "8",
              style: TextStyle(
                  color: Colors.yellow[200],
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height:30),
            Row(
              children: <Widget>[
                Icon(
                    Icons.email,
                    color: Colors.grey[400]
                ),
                SizedBox(width: 10),
                Text(
                  "toadityamittal@gmail.com",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18,
                    letterSpacing: 2,
                  ),
                ),
                TextButton(
                  child: const Text('Get Symbl Stuff'),
                  onPressed: () {
                    fetchSymbl();},
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Future<http.Response> fetchSymbl() {
    return http.get(Uri.parse('https://api-labs.symbl.ai/v1/process/text?enableSummary=true'));
  }
}

