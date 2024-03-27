import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';







class Home extends StatelessWidget {
   Home({super.key});

final AuthService _auth = AuthService();

  void showSettingsPanel (BuildContext context) {
      showModalBottomSheet(context: context, builder: (context){
     return SettingsForm();
    });
    }

  @override

  Widget build(BuildContext context) {

  
     
return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: '').brewsStream,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew crew',
          style: TextStyle(
            color: Colors.white
          ),
          ),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.person,
              color: Colors.white,),
               label: const Text (
                'logout',
                style: TextStyle(
                  color: Colors.white
                ),
                
                ),
               onPressed: () async {
                 await _auth.signOut();
               },
               ),
               TextButton.icon
               (onPressed: () => showSettingsPanel(),
                icon: const Icon (Icons.settings,
                color: Colors.white),
                 label: const Text('settings',
                 style: TextStyle(
                  color: Colors.white
                ),
                 ),
                 )
          ],
        ),
        body: const BrewList(),
      ),
    );
    
  }
}