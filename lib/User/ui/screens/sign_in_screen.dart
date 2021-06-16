import 'package:flutter_fcm/User/bloc/bloc_user.dart';
import 'package:flutter_fcm/User/model/user.dart';
import 'package:flutter_fcm/platzi_trips_cupertino.dart';
import 'package:flutter_fcm/widgets/button_green.dart';
import 'package:flutter_fcm/widgets/gradient_back.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  UserBloc userBloc;
  AsyncSnapshot snapshot;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(
        context); //Este bloc es de tipo singleton, lo instanciaremos a traves del provider. El context es el estado de la app

    return _handleCurrentSession();
  }

  //Aca creamos otro metodo que "maneje" el estado de la sesion
  Widget _handleCurrentSession() {
    return StreamBuilder(
        stream: userBloc.authStatus,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //snapshot de aca contiene la data, el objeto user. Abajo se hace algo si no hay data de inicio de sesion
          if (!snapshot.hasData || snapshot.hasError) {
            return signInGoogleUi();
          } else {
            return PlatziTripsCupertino(); //Al detectar un cambio de estado (i.e. hacer signout) manda a PlatziTripsCupertino
          }
        });
  }

  Widget signInGoogleUi() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        //Porque tengo un fondo de pantalla y los botones sobre el
        children: [
          GradientBack(height: null
              //Porque asi se llena la pantalla completa
              ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: screenWidth,
                  child: Text(
                    "Welcome\nThis is your Travel App",
                    style: TextStyle(
                        fontSize: 37.0,
                        fontFamily: "Lato",
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ButtonGreen(
                buttonText: "Login with Gmail",
                onPressed: () {
                  userBloc.signOut();
                  userBloc.signIn().then((User user) {
                    //Acá User es un objeto de firebase que sale de cuando hacemos signIn, por esto cree el otro como UserPL
                    userBloc.updateUserData(UserPL(
                        uid: user.uid,
                        name: user.displayName,
                        email: user.email,
                        photoURL: user.photoURL));
                  });
                },
                width: 300.0,
                height: 50.0,
              )
            ],
          )
        ],
      ),
    );
  }
}
