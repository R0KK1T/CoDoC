import 'package:flutter/material.dart';


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

  Padding _textFieldName(controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26),
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

  Padding _textFieldEmail(controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26),
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

  Padding _textFieldPass(controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "New Password",
        ),
      ),
    );
  }

  Container _profilePic() {
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
