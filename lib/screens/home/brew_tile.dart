import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  const BrewTile({super.key, required this.brew});

  final Brew brew;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strenght],
            ),
            title: Text(brew.name),
            subtitle: Text('Takes ${brew.sugars} sugars'),
        ),
      ),
      );
  }
}