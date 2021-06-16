import 'package:flutter/material.dart';

class ButtonGreen extends StatefulWidget {
  final double width;
  final double height;
  final String buttonText;
  final VoidCallback
      onPressed; //Esta variable puede recibir una funcion como parametro

  ButtonGreen({
    Key key,
    @required this.buttonText,
    @required this.onPressed,
    this.height = 0.0,
    this.width =
        0.0, //Dart pide que esta tenga que ser de tipo final por ser requerida
  });
  @override
  _ButtonGreenState createState() => _ButtonGreenState();
}

class _ButtonGreenState extends State<ButtonGreen> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget
          .onPressed, //Para acceder a los parametros de mas arriba desde una clase interna
      child: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
                colors: [Color(0xFF81eb9d), Color(0xFF009427)],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: "Lato",
                color: Color(0xFF455250),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
