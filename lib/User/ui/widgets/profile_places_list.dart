import 'package:flutter_fcm/User/model/user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../../User/bloc/bloc_user.dart';

// ignore: must_be_immutable
class ProfilePlacesList extends StatelessWidget {
  UserBloc userBloc;
  UserPL userPL;

  ProfilePlacesList(this.userPL);

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: StreamBuilder(
          stream: userBloc.myPlacesListStream(userPL.uid),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                return Column(
                  children: userBloc.buildMyPlaces(
                      snapshot.data.docs), //recibe una lista de profile_places
                );
              case ConnectionState.active:
                return Column(
                  children: userBloc.buildMyPlaces(
                      snapshot.data.docs), //recibe una lista de profile_places
                );
              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
                return Column(
                  children: userBloc.buildMyPlaces(
                      snapshot.data.docs), //recibe una lista de profile_places
                );
            }
          }), //Una vez pasa algo en el Stream, este es el que construye
    );
  }
  /*
   Column(
        children: <Widget>[
          ProfilePlace(place),
          ProfilePlace(place2),
        ],
      ),*/
}
