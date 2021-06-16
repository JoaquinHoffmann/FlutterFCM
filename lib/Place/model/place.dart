import 'package:flutter/material.dart';
//import 'package:curso_de_flutter_avanzado_en_platzi/User/model/user.dart';

class Place {
  String id;
  String name;
  String description;
  String urlImage;
  int likes;
  bool liked;
  //UserPL userOwner;

  Place({
    Key key,
    this.id,
    @required this.name,
    @required this.description,
    @required this.urlImage,
    this.likes,
    this.liked,
    //this.userOwner  Lo saca porque ya no se comporta como un tipo User sino que como referencia
  });
}
