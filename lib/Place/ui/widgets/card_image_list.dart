import 'package:flutter_fcm/Place/model/place.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'card_image.dart';
import '../../../User/bloc/bloc_user.dart';
import '../../../User/model/user.dart';

class CardImageList extends StatefulWidget {
  final UserPL userPL;
  CardImageList({@required this.userPL});
  @override
  _CardImageListState createState() {
    return _CardImageListState();
  }
}

UserBloc userBloc;

class _CardImageListState extends State<CardImageList> {
  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
        height: 350.0,
        child: StreamBuilder(
            stream: userBloc.placesListStream,
            // ignore: missing_return
            builder: (context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  print("PLACESLIST: WAITING");
                  return CircularProgressIndicator();
                case ConnectionState.none:
                  print("PLACESLIST: NONE");
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  print("PLACESLIST: ACTIVE");
                  return listViewPlaces(userBloc.buildPlaces(
                      snapshot.data.docs,
                      widget
                          .userPL)); //Basicamente el snapshot.data().doc entrega una lista de documentos
                case ConnectionState.done:
                  print("PLACESLIST: DONE");
                  return listViewPlaces(
                      userBloc.buildPlaces(snapshot.data.docs, widget.userPL));
                default:
                  print("PLACESLIST: DEFAULT");
              }
            })); //Porque queremos estar pendientes de cuando la info cambie
  }

  Widget listViewPlaces(List<Place> places) {
    void setLiked(Place place) {
      setState(() {
        place.liked = !place.liked;
        userBloc.likePlace(place, widget.userPL.uid);
        place.likes = place.liked ? place.likes + 1 : place.likes - 1;
        userBloc.placeSelectedSink.add(place);
      });
    }

    IconData iconDataLiked = Icons.favorite;
    IconData iconDataLike = Icons.favorite_border;
    return ListView(
      padding: EdgeInsets.all(25.0),
      scrollDirection: Axis.horizontal,
      children: places.map((place) {
        return GestureDetector(
          onTap: () {
            print("CLICK PLACE: ${place.name}");
            userBloc.placeSelectedSink.add(place);
          }, //El GestureDetector permite que un area especifica sea clickeable
          child: CardImageWithFabIcon(
            pathImage: place.urlImage,
            width: 300.0,
            height: 250.0,
            left: 20.0,
            iconData: place.liked ? iconDataLiked : iconDataLike,
            name: place.name,
            likes: place.likes,
            onPressedFabIcon: () {
              setLiked(place);
            },
            internet: true,
          ),
        );
      }).toList(),
    );
  }
}
