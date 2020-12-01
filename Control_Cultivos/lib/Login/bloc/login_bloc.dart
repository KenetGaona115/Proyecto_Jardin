import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Control_Cultivos/Models/UserAccount.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Firestore _firestore = Firestore.instance;
  List<UserAccount> _list = List();
  List<UserAccount> get getUserAccount => _list;
  File _chooseImage;
  String _url;

  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is InitEvent) {
      if (await _getData()) {
        yield LoginInitial();
      }
    } else if (event is ChooseImageEvent) {
      if (await _chooseImageFunct()) {
        yield GetImageState(image: _chooseImage);
      } else {
        yield ErrorState(errmensage: "no se pudo ");
      }
    } else if (event is UploadFileEvent) {
      bool fileUploaded = await _uploadFile();
      if (fileUploaded) {
        yield UploadedState(image: _url);
      } else {
        yield ErrorState(errmensage: "no se pudo cargar la imagen");
      }
    } else if (event is CreateNewPlatEvent) {
      yield AddImageState();
    } else if (event is SaveDataEvent) {
      print(
          ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(event.annotations);
      print(event.family);
      print(event.name);
      bool saved = await _saveImage(
        event.image,
        event.name,
        event.annotations,
        event.family,
      );
      if (saved) {
        yield CloudStoreSaved();
      } else
        yield ErrorState(
          errmensage: "Ha ocurrido un error. Intente guardar más tarde.",
        );
    }
  }

  //functions

  Future<bool> _getData() async {
    try {
      var x = await _firestore.collection("UserDate").getDocuments();
      _list = x.documents
          .map(
            (x) => UserAccount(
              email: x["email"],
              password: x["password"],
            ),
          )
          .toList();

      for (var item in _list) {
        print(item.email);
        print(item.password);
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _chooseImageFunct() async {
    try {
      await ImagePicker.pickImage(
              source: ImageSource.gallery,
              maxHeight: 720,
              maxWidth: 720,
              imageQuality: 50)
          .then((image) {
        _chooseImage = image;
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _uploadFile() async {
    try {
      String filePath = _chooseImage.path;
      StorageReference reference = FirebaseStorage.instance
          .ref()
          .child("UserPlants/${Path.basename(filePath)}");
      StorageUploadTask uploadTask = reference.putFile(_chooseImage);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      taskSnapshot.ref.getDownloadURL().then((imageUrl) {
        //print("Link>>>>> $imageUrl");
      });

      await reference.getDownloadURL().then((fileURL) {
        //print("$fileURL");
        _url = fileURL;
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> _saveImage(image, name, annotations, family) async {
    print(image.toString());
    print(name);
    print(annotations);
    print(family);
    try {
      await _firestore.collection("MisPlantas").document().setData({
        "name": name,
        "annotations": annotations,
        "family": family,
        "image": image
      });
      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}
