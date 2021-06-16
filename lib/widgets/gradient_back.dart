import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GradientBack extends StatelessWidget {
  //final String title;
  double height;
  GradientBack(
      {Key key,
      this.height}); //vamos a poner la condicion height = null => full screen

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context)
        .size
        .height; //Con esto le damos el tamaño de la pantalla del telefono
    double screenWidth = MediaQuery.of(context).size.width;

    if (height == null) {
      height = screenHeight;
    }

    return Container(
        width: screenWidth,
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF4268D3), Color(0xFF584CD1)],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: FittedBox(
          fit: BoxFit.none,
          alignment: Alignment(-1.5, -0.8),
          child: Container(
            width: screenHeight,
            height: screenHeight,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              borderRadius: BorderRadius.circular(screenHeight / 2),
            ),
          ),
        )
        /*Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontFamily: "Lato",
            fontWeight: FontWeight.bold),
      ),
      alignment: Alignment(-0.9, -0.6)*/
        );
  }
}
