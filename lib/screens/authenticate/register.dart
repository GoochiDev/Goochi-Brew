import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import'package:flutter/material.dart';
import 'package:brew_crew/shared/constant.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  const Register ({super.key, required this.toggleView});
     
     //Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
String email = '';
String password ='';
String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() :Scaffold(
    backgroundColor: Colors.brown[100],
    appBar: AppBar(
      backgroundColor: Colors.brown[400],
      elevation: 0.0,
      title: const Text(
        'Sign up to Brew crew',
      style: TextStyle(
        color: Colors.white
      ),
      ),
      actions:[
       TextButton.icon(
  icon: const Icon(Icons.person,
  color: Colors.white,),
  label: const Text(
    'Sign in',
    style: TextStyle(color: Colors.white), // Text color
  ),
  onPressed: () {
    widget.toggleView();
    // Add your onPressed logic here
  },
)

        ]
    ),
    body: Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            TextFormField(
               decoration: textInputDecoration.copyWith(hintText: 'Email'),
              validator:  (val) => val!.isEmpty ? 'Enter an Email' : null,
              onChanged: (val) {
               setState(() => email = val);
              },
            ),
            const SizedBox(height: 20.0),
            TextFormField( 
              decoration: textInputDecoration.copyWith(hintText: 'Password'),
              validator:  (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              obscureText: true,
              onChanged: (val) {
                setState(() => password = val);

              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
             style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[400], // Background color
              ),
               
                child: const Text(
                   'Register',
                style: TextStyle(color: Colors.white),
                        ),
                   onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      
                    loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                   setState(() {error = 
                   'please supply a valid email';
                   loading = false;
                    });
                    }
                  }
                   
                      
                },     
                  ),
                  const SizedBox(height: 12.0),
                  Text (
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 13.0),
                  ),

          ],
        )

       ,)
     ),
    );
  }
}