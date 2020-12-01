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
  Widget build(BuildContext context) {
    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: BlocProvider(
          create: (context) {
            _bloc = LoginBloc()..add(CreateNewPlatEvent());
            return _bloc;
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is GetImageState) {
                _chooseimage = state.image;
              }
              if (state is UploadedState) {
                _url = state.image;
                _saveData();
              }
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
                                width: 200,
                                height: 200,
                              )
                            : Container(
                                height: 150,
                                width: 150,
                                child: Placeholder(
                                  fallbackHeight: 200,
                                  fallbackWidth: 200,
                                ),
                              ),
                        IconButton(
                          icon: Icon(Icons.add_photo_alternate),
                          onPressed: () {
                            _bloc.add(ChooseImageEvent());
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
                        final snackBar =
                            SnackBar(content: Text('Error al crear la planta'));
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      } else {
                        //como validamos que los campos estan llenos, los registramos
                        setState(() {
                          _isLoading = true;
                        });
                        _bloc.add(UploadFileEvent(image: _chooseimage));
                        final snackBar = SnackBar(
                          content: Text('Planta creada con exito'),
                        );
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                        Navigator.of(context).pop();
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
            },
          ),
        ),
      ),
    );
  }

  void _saveData() {
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(annotations_controller.text);
    print(family_controller.text);
    print(_url);
    print(name_controller.text);

    BlocProvider.of<LoginBloc>(context).add(
      SaveDataEvent(
        annotations: annotations_controller.text,
        family: family_controller.text,
        image: _url,
        name: name_controller.text,
      ),
    );
    _isLoading = false;
    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      Navigator.of(context).pop();
    });
  }

  _pushAccount() async {
    try {
      await _firestore.collection("MisPlantas").document().setData(
        {
          "name": name_controller.text,
          "annotations": annotations_controller.text,
          "family": family_controller.text,
          "image": _url
        },
      );
      //vaciamos los campos
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
