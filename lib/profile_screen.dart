import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyProfilePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key, required this.title});
  final String title;

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            _profilePic(),
            Padding(padding: EdgeInsets.only(bottom: 48)),
            _textFieldName(controllerName),
            Padding(padding: EdgeInsets.only(bottom: 24)),
            _textFieldEmail(controllerEmail),
            Padding(padding: EdgeInsets.only(bottom: 24)),
            _textFieldPass(controllerPass),
            Padding(padding: EdgeInsets.only(bottom: 24)),
            SizedBox(
              height: 40,
              child: FilledButton(
                onPressed: () {},
                child: const Text('Save'),
              ),
            ),
            // const SizedBox(height: 30),
          ]),
        ),
        // const SizedBox(width: 30),
      ),
    );
  }

  SizedBox _textFieldName(controller) {
    return SizedBox(
      width: 340,
      child: TextField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Name",
        ),
      ),
    );
  }

  SizedBox _textFieldEmail(controller) {
    return SizedBox(
      width: 340,
      child: TextField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "E-mail",
        ),
      ),
    );
  }

  SizedBox _textFieldPass(controller) {
    return SizedBox(
      width: 340,
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Password",
        ),
      ),
    );
  }

  Widget _profilePic() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/avatar2.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
