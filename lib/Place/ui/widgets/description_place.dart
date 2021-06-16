import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../../widgets/button_purple.dart';
import '../../../User/bloc/bloc_user.dart';
import '../../model/place.dart';

class DescriptionPlace extends StatelessWidget {
  final String namePlace;
  final int stars;
  final String descriptionPlace;

  DescriptionPlace(this.namePlace, this.stars, this.descriptionPlace);

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of(context);

    return StreamBuilder<Place>(
      stream: userBloc.placeSelectedStream,
      builder: (BuildContext context, AsyncSnapshot<Place> snapshot) {
        if (snapshot.hasData) {
          Place place = snapshot.data;
          print("PLACE SELECTED: ${place.name}");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              titleStars(place),
              descriptionWidget(place.description),
              ButtonPurple(
                buttonText: "Navigate",
                onPressed: () {},
              )
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 400.0, left: 20.0, right: 20.0),
                child: Text(
                  "Selecciona un lugar",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget titleStars(Place place) {
    final nombre = Text(
      '${place.name}',
      style: TextStyle(
          fontFamily: "Lato", fontSize: 30.0, fontWeight: FontWeight.w900),
    );
    final votos = Text(
      "\nLikes: ${place.likes}",
      style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.amber),
      textAlign: TextAlign.left,
    );
    return Padding(
        padding: EdgeInsets.only(top: 350.0, left: 20.0, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[nombre, votos],
        ));
  }

  Widget descriptionWidget(String descriptionPlace) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Text(
        descriptionPlace,
        style: const TextStyle(
            fontFamily: "Lato",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF56575a)),
      ),
    );
  }
}
