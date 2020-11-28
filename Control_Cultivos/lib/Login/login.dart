import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email_controller;
  TextEditingController password_controller;
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    //variables para los tamaños
    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: heigth * .05,
            ),
            CircleAvatar(
              minRadius: heigth * .05,
              maxRadius: width * .15,
              backgroundImage: NetworkImage(
                "https://scontent.fgdl5-2.fna.fbcdn.net/v/t31.0-8/17492966_959961907473788_1175562466240134332_o.jpg?_nc_cat=101&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeFI19Ex_xcKQsB0wmr-esrHEVdOqbP_b0kRV06ps_9vSWYLrqfQht2lfw02bvnyePbn5EXDP5h4qJIkuEILfsSD&_nc_ohc=cG4YBP9BNFsAX8oSFJK&_nc_ht=scontent.fgdl5-2.fna&oh=8e611e7d7d5b7c021bf83fef2746c6a4&oe=5FE98B12",
              ),
            ),
            SizedBox(
              height: heigth * .02,
            ),
            Text("Ingrese sus datos"),
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
                    decoration: InputDecoration(
                      hintText: 'correo electronico',
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'contraseña',
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {}, //validation function
              color: Colors.blueGrey,
              child: Text(
                "Ingresar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
