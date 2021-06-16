import 'package:flutter_fcm/Place/model/place.dart';
import 'package:flutter/material.dart';

class UserPL {
  final String uid;
  final String name;
  final String email;
  final String photoURL;
  final List<Place> myPlaces;
  final List<Place> myFavoritePlaces;

  //myFavoritePlaces
  //Places

  UserPL(
      {Key key,
      this.uid,
      @required this.name,
      @required this.email,
      @required this.photoURL,
      this.myPlaces,
      this.myFavoritePlaces});
}
