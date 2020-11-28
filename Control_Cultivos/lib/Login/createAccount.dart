import 'package:Control_Cultivos/Login/login.dart';
import 'package:flutter/material.dart';

class CreateNewAccount extends StatefulWidget {
  CreateNewAccount({Key key}) : super(key: key);

  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  TextEditingController email_controller = new TextEditingController();
  TextEditingController password_controller = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            SizedBox(
              height: heigth * .05,
            ),
            Text(
              "Crear cuenta",
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
                  TextField(
                    controller: email_controller,
                    decoration: InputDecoration(
                      hintText: 'ingrese su correo electronico',
                    ),
                  ),
                  TextField(
                    controller: password_controller,
                    decoration: InputDecoration(
                      hintText: 'ingrese su contraseña',
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                if (email_controller.text == "" ||
                    password_controller.text == "") {
                  final snackBar =
                      SnackBar(content: Text('Error al crear cuenta'));
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                } else {
                  //como validamos que los campos estan llenos, los registramos
                  //await _pushOrder();
                  final snackBar = SnackBar(
                    content: Text('Cuenta creada con exito'),
                  );
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                  email_controller.text = "";
                  password_controller.text = "";
                }
              }, //validation function
              color: Colors.blueGrey,
              child: Text(
                "Crear cuenta",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: heigth * .1,
            ),
            Text("¿Ya tienes cuenta?"),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(),
                  ),
                );
              }, //go to register page
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: heigth * .07,
                  ),
                  Text(
                    "Iniciar sesion",
                    style: TextStyle(fontSize: heigth * .03),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
