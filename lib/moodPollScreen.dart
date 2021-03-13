import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoodPollScreen extends StatefulWidget {
  @override
  _MoodPollScreenState createState() => _MoodPollScreenState();
}

class _MoodPollScreenState extends State<MoodPollScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stimmungsabfrage"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(100, 200, 50, 100),
              padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
              child: Text(
                "Hi",
                style: TextStyle(fontSize: 50),
              ),
            ),
            Text("du"),
            Text("Gauner"),
          ],
        )
      ),
       floatingActionButton: FloatingActionButton(onPressed: () => setState(() {

        })),
    );
  }
}
