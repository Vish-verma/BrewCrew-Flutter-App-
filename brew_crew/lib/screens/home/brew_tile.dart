import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';


class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 30, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Take ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}