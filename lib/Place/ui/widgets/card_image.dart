import 'dart:io';

import 'package:flutter/material.dart';
import '../../../widgets/floating_action_button_green.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardImageWithFabIcon extends StatelessWidget {
  final double height;
  final double width;
  final double left;
  final VoidCallback onPressedFabIcon;
  final IconData iconData;
  final String pathImage;
  final int likes;
  final String name;
  final bool internet;
  final bool labelBool;
  CardImageWithFabIcon(
      {this.height = 350.0,
      this.width = 250.0,
      this.left = 20.0,
      this.onPressedFabIcon,
      @required this.iconData,
      @required this.pathImage,
      this.likes,
      this.name,
      this.internet = true,
      this.labelBool = true});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print("pathImage = $pathImage");

    final like = Text(
      'Likes ${this.likes}',
      style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.amber),
    );
    final nombre = Text(
      '${this.name}',
      style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.amber),
    );

    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: left),
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: internet
                  ? CachedNetworkImageProvider(pathImage)
                  : FileImage(File(pathImage))),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0, 7.0))
          ]),
    );

    final label = Container(
      width: screenWidth * 0.65,
      height: 70.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0))
          ]),
      child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[nombre, like],
          )),
    );
    final child1 = labelBool
        ? <Widget>[
            card,
            label,
            FloatingActionButtonGreen(
              iconData: iconData,
              onPressed: onPressedFabIcon,
            )
          ]
        : <Widget>[
            card,
            FloatingActionButtonGreen(
              iconData: iconData,
              onPressed: onPressedFabIcon,
            )
          ];
    return Stack(
      alignment: Alignment(0.9, 1.1),
      children: child1,
    );
  }
}
