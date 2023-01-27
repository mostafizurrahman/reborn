import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Welcome"),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        hintText: "Enter your name",
                        border: OutlineInputBorder()),
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text("Submit"),
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
