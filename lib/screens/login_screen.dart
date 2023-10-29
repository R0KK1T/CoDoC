import 'package:codoc/screens/signup_screen.dart';
import 'package:codoc/screens/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase/firebase_options.dart';
import 'package:codoc/firebase/firebase_authentication.dart';
import 'package:codoc/utils/utils.dart';

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
    String authenticationResponse = await AuthMethods().authUserSignIn(
        email: _emailController.text, password: _passwordController.text);
    if (authenticationResponse == 'success') {
      debugPrint("Successfully logged in");
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MyHomePage(
                groupName: 'CLS055 Grupp 12',
                groupId: '123',
                fromLogin: true,
              ),
            ),
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
                'CoLog',
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
              FilledButton(
                onPressed: () {
                  loginUser();
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                    // fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  debugPrint('Signin button tapped'); //Debugger

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: const Text('No account? Sign up here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
