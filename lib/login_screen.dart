import 'package:codoc/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
    return MaterialApp(
      routes: {
        '/signup': (context) => SignUpScreen(),
      },
      title: 'CoDoc',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyLoginScreen(),
    );
  }
}

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() {
    return _MyLoginScreenState();
  }
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Text
              Text(
                'CoDoc',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w300,
                ),
              ),

              // username,
              Padding(
                padding: const EdgeInsets.only(
                    left: 26, top: 24, right: 26, bottom: 24.00),
                child: TextFormField(
                  //controller: controller,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                  ),
                ),
              ),

              // password,
              Padding(
                padding:
                    const EdgeInsets.only(left: 26, right: 26, bottom: 24.00),
                child: TextFormField(
                  //controller: controller,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
              ),

              //Login Button
              SizedBox(
                // width: 300.0,
                height: 40.0,
                child: FilledButton(
                  onPressed: () {}, //WHY DO I NEED NULL????
                  child: Text(
                    'Login',
                    style: TextStyle(
                      // fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  bottom: 40.00,
                ),
              ),

              //Text (Or log in with)
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Text(
                  'Or log in with',
                ),
              ),

              Image.asset(
                'assets/images/googleicon.png', // Replace with the path to your image file
                width: 50, // Set the width of the image
                height: 50, // Set the height of the image
              ),

              //Signup
              const SizedBox(height: 10),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  print('Signup button tapped'); //Debugger

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: const Text('Sign up here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
