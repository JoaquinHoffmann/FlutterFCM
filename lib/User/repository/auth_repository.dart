import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fcm/User/repository/firebase_auth_api.dart';
//import 'package:firebase_core/firebase_core.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();
  Future<User> signInFirebase() {
    return _firebaseAuthAPI.signIn();
  }

  signOut() => _firebaseAuthAPI
      .signOut(); //Acá está apareciendo el método que se creó en firebase_auth_api
}
