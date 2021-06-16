import 'dart:io';

import 'package:flutter_fcm/Place/ui/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../../User/ui/widgets/circle_button.dart';
import 'package:flutter_fcm/User/bloc/bloc_user.dart';
import 'package:image_picker/image_picker.dart'; //Tuve que eliminar la carpeta .pub-cache (C:\src\flutter\.pub-cache) y correr flutter pub get

// ignore: must_be_immutable
class ButtonsBar extends StatelessWidget {
  UserBloc
      userBloc; //Hay que crear esta variable para tener acceso al método signout()
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            CircleButton(true, Icons.turned_in_not, 20.0,
                Color.fromRGBO(255, 255, 255, 1), () => {}),
            //Este para cambiar contraseña
            CircleButton(true, Icons.vpn_key, 20.0,
                Color.fromRGBO(255, 255, 255, 0.6), () => {}),
            //Añadir lugar
            CircleButton(
                false, Icons.add, 40.0, Color.fromRGBO(255, 255, 255, 1),
                () async {
              await ImagePicker()
                  .getImage(
                      source: ImageSource.camera, maxHeight: 480, maxWidth: 640)
                  .then((pickedFile) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AddPlaceScreen(imagen: File(pickedFile.path))));
              }).catchError((onError) => print(onError));
            }),

            //Cerrar sesión
            CircleButton(true, Icons.exit_to_app, 20.0,
                Color.fromRGBO(255, 255, 255, 0.6), () => {userBloc.signOut()}),
            CircleButton(true, Icons.person, 20.0,
                Color.fromRGBO(255, 255, 255, 0.6), () => {})
          ],
        ));
  }
}
