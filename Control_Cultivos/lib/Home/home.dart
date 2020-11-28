import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Control de cultivos"),
        ),
        body: ListBody(
          children: [
            Card(
              child: Row(
                children: [
                  CircleAvatar(),
                  Column(
                    children: [
                      Text("data"),
                      Text("data"),
                      Text("data"),
                      Text("data"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
