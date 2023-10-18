import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
//CoDoC
              Text(
                'CoDoc',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w300,
                ),
              ),

// Email
              Padding(
                padding: const EdgeInsets.only(
                    left: 26, top: 24, right: 26, bottom: 24.00),
                child: TextFormField(
                  //controller: controller,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ),

              // username,
              Padding(
                padding:
                    const EdgeInsets.only(left: 26, right: 26, bottom: 24.00),
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

              //Sign up Button
              SizedBox(
                // width: 300.0,
                height: 40.0,
                child: FilledButton(
                  onPressed: () {}, //WHY DO I NEED NULL????
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      // fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),

              //Text (Or log in with)
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: 10.0,
                ),
                child: Text(
                  'Or sign up with',
                ),
              ),

              Image.asset(
                'assets/images/googleicon.png', // Replace with the path to your image file
                width: 50, // Set the width of the image
                height: 50, // Set the height of the image
              ),
            ],
          ),
        ),
      ),
    );
  }
}
