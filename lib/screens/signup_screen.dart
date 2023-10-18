import 'package:codoc/firebase/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

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
                  controller: _emailController,
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
                  controller: _usernameController,
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
                  controller: _passwordController,
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
                  onPressed: () async {
                    String response = await AuthMethods().signUpUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                        username: _usernameController.text);
                    print(response);
                  }, //WHY DO I NEED NULL????
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
