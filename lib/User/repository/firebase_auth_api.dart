import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; //Todo lo que hay en Firebase authetication
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> signIn() async {
    //Devuelve un futuro en flutter
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA =
        await googleSignInAccount.authentication; //Obtiene las credenciales

    UserCredential userCredential = (await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: gSA.idToken, accessToken: gSA.accessToken)));
    return userCredential.user;
  }

  void signOut() async {
    await _auth.signOut().then((onValue) => print("Sesión cerrada"));
    googleSignIn.signOut(); //esta no se había cerrado en google, solo firebase
    print("Sesiones cerradas");
  }
}
