//import 'dart:html';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fcm/Place/model/place.dart';
import 'package:flutter_fcm/User/repository/auth_repository.dart';
import 'package:flutter_fcm/User/repository/cloud_firestore_api.dart';
import 'package:flutter_fcm/User/repository/cloud_firestore_repository.dart';
import 'package:flutter_fcm/User/model/user.dart';
import 'package:flutter_fcm/User/ui/widgets/profile_place.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter_fcm/Place/repository/firebase_storage_repository.dart';
import '../repository/cloud_firestore_api.dart';
//import 'package:curso_de_flutter_avanzado_en_platzi/User/repository/firebase_auth_api.dart';

class UserBloc implements Bloc {
  final authRepository = AuthRepository();
  //Flujo de datos -Streams
  //Stream - Firebase
  //StreamController

  Stream<User> streamFirebase = FirebaseAuth.instance.authStateChanges();
  //Quiero monitorear el estado de la sesion en la pantalla SignIn
  Stream<User> get authStatus => streamFirebase;

  //Casos de uso de la app
  //1. SignIn a la app con Google
  Future<User> signIn() => authRepository.signInFirebase();

  //2. Registrar usuario en base de datos
  final _cloudFirestoreRepository =
      CloudFirestoreRepository(); //Creamos la entidad para poder llamar al método
  void updateUserData(UserPL userPL) =>
      _cloudFirestoreRepository.updateUserDataFirestore(userPL);

  Future<void> updatePlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);

  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection("places")
      .snapshots(); //Trae una instantanea de lo que hay en la collección places y además sigue en escucha, para que los cambios que detecte los refleje en la UI

  List<Place> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, UserPL userPL) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot, userPL);

  Future likePlace(Place place, String uid) =>
      _cloudFirestoreRepository.likePlace(place, uid);

  Stream<QuerySnapshot> get placesStream =>
      placesListStream; //Este stream accede al otro y lo escucha
  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildMyPlaces(placesListSnapshot);

  Stream<QuerySnapshot> myPlacesListStream(String uid) => FirebaseFirestore
      .instance
      .collection(CloudFirestoreAPI().PLACES)
      .where("userOwner",
          isEqualTo: FirebaseFirestore.instance
              .doc("${CloudFirestoreAPI().USERS}/${uid}"))
      .snapshots(); //Con .snapshots terminó convirtiendo la cadena a un Stream

  User usuarioActual = FirebaseAuth.instance.currentUser;
  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  StreamController<Place> placeSelectedStreamController = StreamController<
      Place>.broadcast(); //Necesitamos que el streamController escuche al place que seleccionaremos
  Stream get placeSelectedStream => placeSelectedStreamController
      .stream; //Se transforma para que el StreamController pueda leer StreamBuilder
  StreamSink get placeSelectedSink =>
      placeSelectedStreamController.sink; //Con esto se inserta el Place

  signOut() {
    authRepository.signOut();
  }

  void dispose() {}
}
