import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fcm/Place/model/place.dart';
import 'package:flutter_fcm/User/model/user.dart';
import 'package:flutter_fcm/User/ui/widgets/profile_place.dart';
//import 'package:curso_de_flutter_avanzado_en_platzi/User/repository/firebase_auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreAPI {
  final String USERS = "users"; //Estas van a a ser las colleciones
  final String PLACES = "places";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateUserData(UserPL userPL) async {
    DocumentReference ref = _db.collection(USERS).doc(userPL.uid);
    return ref.set({
      'uid': userPL.uid,
      'name': userPL.name,
      'email': userPL.email,
      'photoURL': userPL.photoURL,
      'myPlaces': userPL.myPlaces,
      'myFavoritePlaces': userPL.myFavoritePlaces,
      'lastSignIn': DateTime.now(),
      'dispositivo': userPL.dispositivo
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _db.collection(PLACES);
    //Este método va a generar un identificador unico y autoincremental
    User user = _auth.currentUser;
    refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'urlImage': place.urlImage,
      'userOwner':
          _db.doc("$USERS/${user.uid}"), //tipo de dato conocido como reference
      'userDirection': "$USERS/${user.uid}", //Lo necesito como string
    }).then((DocumentReference dr) => {
          dr.get().then((DocumentSnapshot snapshot) {
            DocumentReference refUsers = _db.collection(USERS).doc(user
                .uid); //Obtengo el usuario que tiene una id especifica y lo almaceno en refUsers
            refUsers.update({
              'myPlaces':
                  FieldValue.arrayUnion([_db.doc("$PLACES/${snapshot.id}")])
            });
          })
        });
  }

  //Creamos un método que devuelve una lista de profile places
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) {
    List<ProfilePlace> profilePlaces = [];
    placesListSnapshot.forEach((p) {
      var ndata = p.data() as Map;
      profilePlaces.add(ProfilePlace(Place(
          name: ndata['name'],
          description: ndata['description'],
          urlImage: ndata['urlImage'],
          likes: ndata["likes"])));
    });

    return profilePlaces;
  }

  List<Place> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot, UserPL userPL) {
    List<Place> places = <Place>[];
    placesListSnapshot.forEach((p) {
      var ndata = p.data() as Map;
      Place place = Place(
          id: p.id,
          name: ndata["name"],
          description: ndata["description"],
          urlImage: ndata["urlImage"],
          likes: ndata["likes"]);
      List usersLikedRefs = ndata["usersLiked"];
      place.liked = false;
      usersLikedRefs?.forEach((drUL) {
        if (userPL.uid == drUL.id) {
          place.liked = true;
        }
      });
      places.add(place);
    });
    return places;
  }

  Future likePlace(Place place, String uid) async {
    await _db
        .collection(PLACES)
        .doc(place.id)
        .get()
        .then((DocumentSnapshot ds) {
        var ndata = ds.data() as Map;
      int likes = ndata["likes"]; //Obtiene los likes
      _db.collection(PLACES).doc(place.id).update({
        'likes': place.liked
            ? likes + 1
            : likes - 1, //le suma o resta 1 dependiendo de la acción
        'usersLiked': place.liked
            ? FieldValue.arrayUnion([_db.doc("$USERS/$uid")])
            : FieldValue.arrayRemove([_db.doc("$USERS/$uid")])
      });
    });
  }
}
