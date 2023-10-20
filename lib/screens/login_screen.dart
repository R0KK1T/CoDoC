import 'package:codoc/screens/signup_screen.dart';
import 'package:codoc/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase/firebase_options.dart';
import 'package:codoc/firebase/firebase_authentication.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:codoc/utils/utils.dart';

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

const double horizontalPadding = 26;
const double verticalPadding = 24;

class _MyLoginScreenState extends State<MyLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // ignore: unused_field
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String authenticationResponse = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (authenticationResponse == 'success') {
      debugPrint("Successfully logged in");
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: 'abcde',
                    )),
            (route) => false);

        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, authenticationResponse);
      }
    }
  }

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

              //Email
              Padding(
                padding: const EdgeInsets.only(
                    left: horizontalPadding,
                    top: verticalPadding,
                    right: horizontalPadding,
                    bottom: verticalPadding),
                child: TextFormField(
                  controller: _emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ),

              // password,
              Padding(
                padding: const EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: verticalPadding,
                ),
                child: TextFormField(
                  controller: _passwordController,
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
                  onPressed: () {
                    loginUser();
                  },
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
                  print('Signin button tapped'); //Debugger

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

