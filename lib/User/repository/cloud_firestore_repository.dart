//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fcm/Place/model/place.dart';
import 'package:flutter_fcm/User/model/user.dart';
import 'package:flutter_fcm/User/repository/cloud_firestore_api.dart';
import 'package:flutter_fcm/User/ui/widgets/profile_place.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();
  void updateUserDataFirestore(UserPL userPL) =>
      _cloudFirestoreAPI.updateUserData(userPL);
  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreAPI.updatePlaceData(place);

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreAPI.buildMyPlaces(placesListSnapshot);
  List<Place> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, UserPL userPL) =>
      _cloudFirestoreAPI.buildPlaces(placesListSnapshot, userPL);

  Future likePlace(Place place, String uid) =>
      _cloudFirestoreAPI.likePlace(place, uid);
}
