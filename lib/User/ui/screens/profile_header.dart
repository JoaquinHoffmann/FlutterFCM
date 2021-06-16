import 'package:flutter_fcm/User/model/user.dart';
import 'package:flutter/material.dart';
import '../widgets/user_info.dart';
import '../widgets/button_bar.dart';

// ignore: must_be_immutable
class ProfileHeader extends StatelessWidget {
  UserPL userPL;

  ProfileHeader(this.userPL);
  //ProfileHeader(@required this.user);
  @override
  Widget build(BuildContext context) {
    final title = Text(
      'Profile',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0),
    );

    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[title],
          ),
          UserInfo(userPL),
          ButtonsBar()
        ],
      ),
    );
  }

  //en el widget de acá vemos si snapshot tiene data
  // ignore: missing_return
  Widget showProfileData(AsyncSnapshot snapshot) {
    if (!snapshot.hasData || snapshot.hasError) {
      print("No logeado");
      /*return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("No se pudo cargar la información. Por favor inicie sesión")
          ],
        ),
      );*/
    } else {
      print("Logeado");
      userPL = UserPL(
        name: snapshot.data.displayName,
        email: snapshot.data.email,
        photoURL: snapshot.data.photoURL,
      ); //Acá ya tenemos acceso al snapshot
      final title = Text(
        "Profile",
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0),
      );

      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[title],
            ),
            UserInfo(userPL),
            ButtonsBar()
          ],
        ),
      );
    }
  }
}
