import 'dart:typed_data';
import 'package:codoc/firebase/firebase_authentication.dart';
import 'package:codoc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:codoc/screens/feed_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  // ignore: unused_field
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().authUserSignUp(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              groupName: 'Hej',
              groupId: '',
              fromLogin: true,
            ),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  selectImage(ImageSource source) async {
    Uint8List im = await insertImage(source);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //CoDoC
            Text(
              'CoLog',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w300,
              ),
            ),
            // Email
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                      )
                    : IconButton(
                        icon: Icon(Icons.account_circle_outlined),
                        //color: Colors.black,
                        iconSize: 128,
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => SimpleDialog(
                            children: <Widget>[
                              SimpleDialogOption(
                                onPressed: () async {
                                  selectImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                child: const Text('Take picture'),
                              ),
                              SimpleDialogOption(
                                onPressed: () {
                                  selectImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                child: const Text('Choose from gallery'),
                              ),
                            ],
                          ),
                        ),
                      ),
                _image == null
                    ? Positioned(
                        bottom: 10,
                        left: 105,
                        child: Icon(
                          Icons.add,
                          size: 32,
                        ),
                      )
                    : Icon(
                        Icons.abc,
                        color: Colors.transparent,
                      ),
              ],
            ),
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
            FilledButton(
              onPressed: () {
                signUpUser();
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  // fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
