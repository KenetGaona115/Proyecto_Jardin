import 'package:flutter/material.dart';

import '../Models/Plant.dart';
import '../Items/item_plant.dart';

class PlantList extends StatefulWidget {
  List<Plant> plants = new List<Plant>();
  PlantList({Key key, this.plants}) : super(key: key);
  @override
  
  @override
  _PlantListState createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plantas disponibles"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*.85,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: widget.plants.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemPlant(plant: widget.plants[index], index: index,);
              },
            ),
          ),
        ],
      ),
    );
  }
}