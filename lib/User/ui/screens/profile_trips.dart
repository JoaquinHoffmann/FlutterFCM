import 'package:flutter_fcm/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'profile_header.dart';
import '../widgets/profile_places_list.dart';
import '../widgets/profile_background.dart';
import '../../bloc/bloc_user.dart';

// ignore: must_be_immutable
class ProfileTrips extends StatelessWidget {
  UserBloc userBloc;
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
        stream: userBloc
            .authStatus, //El streamFirebase tiene la instancia de la auteticación para detectar si ha cambiado algo
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.none:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return showProfileData(snapshot);
            case ConnectionState.done:
              return showProfileData(snapshot);

            default:
          }
        });
    /*return Container(
      color: Colors.indigo,
    );*/
    /*return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeader(), //Este trae los datos
            ProfilePlacesList() //Este trae el identificador
          ],
        ),
      ],
    );*/
  }

  Widget showProfileData(AsyncSnapshot snapshot) {
    //Pasamos el snapshot para capturar el metodo dentro de un objeto user y pasarlo a ProfileHeader y ProfilePlacesList
    if (!snapshot.hasData || snapshot.hasError) {
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              Text("El usuario no ha iniciado sesión, por favor haga inicio")
            ],
          ),
        ],
      );
    } else {
      print("Logueado");
      var userPL = UserPL(
          uid: snapshot.data.uid,
          name: snapshot.data.displayName,
          email: snapshot.data.email,
          photoURL: snapshot.data.photoURL);

      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              ProfileHeader(userPL), //Este trae los datos
              ProfilePlacesList(userPL) //Este trae el identificador
            ],
          ),
        ],
      );
    }
  }
}
