import 'dart:io';

import 'package:Control_Cultivos/Login/bloc/login_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlanta extends StatefulWidget {
  AddPlanta({Key key}) : super(key: key);

  @override
  _AddPlantaState createState() => _AddPlantaState();
}

class _AddPlantaState extends State<AddPlanta> {
  final Firestore _firestore = Firestore.instance;
  TextEditingController name_controller = new TextEditingController();
  TextEditingController family_controller = new TextEditingController();
  TextEditingController annotations_controller = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File _chooseimage;
  String _url;
  LoginBloc _bloc;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = LoginBloc()..add(CreateNewPlatEvent());
  }

  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: BlocProvider(
          create: (context) {
            return _bloc;
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is AddImageState) {
                return Column(
                  children: [
                    SizedBox(
                      height: heigth * .05,
                    ),
                    Text(
                      "Crear nueva planta",
                      style: TextStyle(fontSize: heigth * .04),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        width * .1,
                        heigth * .02,
                        width * .1,
                        heigth * .05,
                      ),
                      child: Column(
                        children: [
                          _chooseimage != null
                              ? Image.file(
                                  _chooseimage,
                                  width: 150,
                                  height: 150,
                                )
                              : Container(
                                  height: 150,
                                  width: 150,
                                  child: Placeholder(
                                    fallbackHeight: 150,
                                    fallbackWidth: 150,
                                  ),
                                ),
                          IconButton(
                            icon: Icon(Icons.add_photo_alternate),
                            onPressed: () {
                              LoginBloc().add(ChooseImageEvent());
                            },
                          ),
                          TextField(
                            controller: name_controller,
                            decoration: InputDecoration(
                              hintText: 'ingrese el nombre de la planta',
                            ),
                          ),
                          TextField(
                            controller: family_controller,
                            decoration: InputDecoration(
                              hintText: 'ingrese su familia',
                            ),
                          ),
                          TextField(
                            controller: annotations_controller,
                            decoration: InputDecoration(
                              hintText: 'ingrese algunas anotaciones',
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (name_controller.text == "" ||
                            family_controller.text == "" ||
                            annotations_controller.text == "") {
                          final snackBar = SnackBar(
                              content: Text('Error al crear la planta'));
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                        } else {
                          //como validamos que los campos estan llenos, los registramos
                          _saveData();
                          final snackBar = SnackBar(
                            content: Text('Planta creada con exito'),
                          );
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                        }
                      }, //validation function
                      color: Colors.blueGrey,
                      child: Text(
                        "Crear planta",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: heigth * .1,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _saveData() {
    BlocProvider.of<LoginBloc>(context).add(
      SaveDataEvent(
          annotations: annotations_controller.text,
          family: family_controller.text,
          image: _url,
          name: name_controller.text),
    );
    _isLoading = false;
    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      Navigator.of(context).pop();
    });
  }
}
