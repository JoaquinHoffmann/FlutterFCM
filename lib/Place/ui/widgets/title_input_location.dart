import 'package:flutter/material.dart';

class TextInputLocation extends StatelessWidget {
  //Este widget siempre recibirá un input de texto
  final String hintText;
  final TextEditingController controller; //Para trabajar el fomulario
  final IconData iconData;
  TextInputLocation(
      {@required this.hintText, this.controller, @required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20.0, left: 20.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: "Lato",
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(
                iconData), //Esto hace que el ícono se vaya al extremo derecho (lo contrario sería prefixIcon)
            fillColor: Color(0xFFFFFFFF),
            filled: true,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                borderRadius: BorderRadius.all(Radius.circular(12.0)))),
      ),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black12,
            blurRadius: 15.0,
            offset: Offset(0.0, 7.0) //Donde empieza la sombra
            )
      ]),
    );
  }
}
