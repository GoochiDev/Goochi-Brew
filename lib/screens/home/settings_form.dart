import 'package:brew_crew/better_stream_builder.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class SettingsForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // Form values
  String _currentName = '';
  String _currentSugar = '';
  int _currentStrength = 100;

  SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

 return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
     return BetterStreamBuilder<DocumentSnapshot>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, DocumentSnapshot<Object?>? snapshot) {
        if (snapshot ==null) {
          return const CircularProgressIndicator();
        } else {
          UserData userData = DatabaseService(uid: '').userDataFromSnapshot(snapshot);

          return Padding(
            padding: const EdgeInsets.fromLTRB(35,15,35,15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0),
                  SingleChildScrollView(
  child: TextFormField(
    initialValue: userData.name,
    decoration: textInputDecoration,
    validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
    onChanged: (val) => 
      _currentName = val,
    
  ),
),

                                                    
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    value: _currentSugar.isEmpty ? userData.sugars : _currentSugar,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugar(s)'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _currentSugar = value as String;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Slider(
                    value: (_currentStrength ?? 100).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? 100],
                    inactiveColor: Colors.brown[_currentStrength ?? 100],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) {
                      setState((){
                           _currentStrength = val.round();
                      });
                    }
                      ,
                    ),
                  
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentSugar.isNotEmpty ? _currentSugar : userData.sugars,
                          _currentName.isNotEmpty ? _currentName : userData.name,
                          _currentStrength,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.pink,
                    ),
                    child: Text('Update'),
                  ),
                ],
              ),
            ),
          );
        } 
      },
    );
  
  },);
  
  }
}
