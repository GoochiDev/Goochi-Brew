import 'package:brew_crew/firebase_options.dart';
import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
  value: AuthService().user,
  
  catchError: (context, error) {
    print('Sign Out: $error');
    // Handle the error gracefully, e.g., show a dialog or log the error
    return null; // Return a default value or null if needed
  },
  initialData: null, // Optional: Provide initial data for the stream
  child: const MaterialApp(
    home: Wrapper(),
  ),
  
);

  }
}
