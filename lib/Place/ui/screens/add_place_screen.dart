import 'dart:io';
import 'package:flutter_fcm/User/bloc/bloc_user.dart';
import 'package:flutter_fcm/Place/model/place.dart';
import 'package:flutter_fcm/Place/ui/widgets/card_image.dart';
import 'package:flutter_fcm/Place/ui/widgets/text_input.dart';
import 'package:flutter_fcm/Place/ui/widgets/title_input_location.dart';
import 'package:flutter_fcm/widgets/button_purple.dart';
import 'package:flutter_fcm/widgets/gradient_back.dart';
import 'package:flutter_fcm/widgets/title_header.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import '../../../User/bloc/bloc_user.dart';

class AddPlaceScreen extends StatefulWidget {
  final File imagen;

  AddPlaceScreen({Key key, this.imagen});
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _controllerTitlePlace = TextEditingController();
  final _controllerDescriptionPlace = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("Hola!");
    UserBloc userBloc = BlocProvider.of(context);
    //final pathImage = widget.imagen.path;
    return Scaffold(
        //Vamos a hacer el botón de "back"
        body: Stack(children: <Widget>[
      GradientBack(
        height: 300.0,
      ),
      Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25.0, left: 5.0),
            child: SizedBox(
              //Esta caja va a tener la misma accion que el botón que contendrá, para que sea más fácil de apretar
              height: 45.0,
              width: 45.0,
              child: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                  size: 45,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
              child: TitleHeader(title: "Add a new place"),
            ),
          ),
        ],
      ),
      Container(
          margin: EdgeInsets.only(top: 120.0),
          child: ListView(children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: CardImageWithFabIcon(
                pathImage: widget.imagen.path,
                //.path, //Extraemos el path de este objeto que es de tipo File
                iconData: Icons.camera_alt,
                width: 350.0,
                height: 250.0,
                left: 0,
                internet: false,
                labelBool: false,
              ),
            ), //Foto
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20.0),
              child: TextInput(
                hintText: "Title",
                inputType: null,
                maxLines: 1,
                controller: _controllerTitlePlace,
              ),
            ),
            TextInput(
                hintText: "Description",
                inputType: TextInputType.multiline,
                controller: _controllerDescriptionPlace),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: TextInputLocation(
                  hintText: "Add location",
                  iconData: Icons.location_on_outlined),
            ),
            Container(
                width: 70.0,
                child: ButtonPurple(
                    buttonText: "Add Place",
                    onPressed: () {
                      //Subimos la imagen a Firebase Storage, hay que preparar los datos para madarlos a Firstore y tambien juntar toda la data (imagen, titulo, likes...)
                      // 1. Firebase Storage
                      //Necesitamos la ID del usuario logeado para crea la carpeta contenedora de sus imágenes (creamos metodo en userbloc para obtenerla)
                      if (userBloc.usuarioActual != null) {
                        String path =
                            "${userBloc.usuarioActual.uid}/${DateTime.now().toString()}.jpg";

                        userBloc
                            .uploadFile(path, widget.imagen)
                            .then((UploadTask storageUploadTask) {
                          // ignore: unused_local_variable
                          TaskSnapshot snapshot;

                          storageUploadTask.then((snapshot) async {
                            String urlImage = await storageUploadTask
                                .snapshot.ref
                                .getDownloadURL();
                            print("URLIMAGE: $urlImage");
                            userBloc.updatePlaceData(Place(
                                name: _controllerTitlePlace
                                    .text, //Obtiene el texto que escribimos en el titulo de la pantalla AddNewPlace
                                description: _controllerDescriptionPlace.text,
                                likes: 0,
                                urlImage: urlImage));
                          });
                        });

                        print('Enviado!');
                      }
                      Navigator.pop(context);
                      /*userBloc.uploadFile(path, widget.imagen).then((takeSnapshot) => {
                        takeSnapshot.ref.getDownloadURL().then((urlPlace) {
                          userBloc.updatePlaceData(Place(
                          name: _controllerTitlePlace.text,
                          description: _controllerDescriptionPlace.text,
                          urlImage: urlPlace,
                          likes: 0,
                          )).whenComplete(() {
                          print("Termino la subida de data");
                          Navigator.pop(context);
                          });*/
                    }))
          ]))
    ]));
  }

  /*
                      //2. Cloud firestore  
                      //Place - title, description, url, userOwner, likes
                      userBloc.updatePlaceData(Place(
                        name: _controllerTitlePlace
                            .text, //Obtiene el texto que escribimos en el titulo de la pantalla AddNewPlace
                        description: _controllerDescriptionPlace.text,
                        likes: 0,
                      ))
                          .whenComplete(() {
                        print('Enviado!');
                        Navigator.pop(context);
                      }); */

}
