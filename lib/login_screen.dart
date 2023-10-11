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
      title: 'CoDoc',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
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
                  padding:
                      const EdgeInsets.only(left: 26, right: 26, bottom: 24.00),
                  child: TextField(
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
                  child: TextField(
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
                    bottom: 24.00,
                  ),
                ),

                //Text (Or log in with)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 24.0,
                  ),
                  child: Text(
                    'Or log in with',
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    bottom: 24.0,
                  ),
                  child: Icon(
                    Icons.beach_access,
                    color: Colors.blue,
                    size: 36.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Widget _padding() {}


             // Padding(
                //   padding: EdgeInsets.only(
                //       left: 27.0, top: 30, right: 27.0, bottom: 24),
                //   child: TextField(
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Username',
                //     ),
                //   ),
                // ),    
