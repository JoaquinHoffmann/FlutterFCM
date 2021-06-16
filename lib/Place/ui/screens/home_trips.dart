import 'package:flutter/material.dart';
import '../widgets/description_place.dart';
import 'header_appbar.dart';
import '../widgets/review_list.dart';

class HomeTrips extends StatelessWidget {
  final String descriptionDummy;
  HomeTrips(this.descriptionDummy);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            DescriptionPlace("Bahamas", 4, descriptionDummy),
            ReviewList()
          ],
        ),
        HeaderAppBar()
      ],
    );
  }
}
