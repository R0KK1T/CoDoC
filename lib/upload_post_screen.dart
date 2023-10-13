import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyUploadPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyUploadPage extends StatefulWidget {
  const MyUploadPage({super.key, required this.title});
  final String title;

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

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
            _photo(),
            Padding(padding: EdgeInsets.only(bottom: 48)),
            _textFieldTitle(controllerTitle),
            Padding(padding: EdgeInsets.only(bottom: 24)),
            _textFieldDescription(controllerDescription),
            Padding(padding: EdgeInsets.only(bottom: 24)),
            Padding(
              padding: const EdgeInsets.only(bottom: 26),
              child: SizedBox(
                height: 40,
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Upload'),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Padding _textFieldTitle(controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26),
      child: TextField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Title",
        ),
      ),
    );
  }

  Padding _textFieldDescription(controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26),
      child: TextField(
        maxLines: 3,
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
          labelText: "Description",
        ),
      ),
    );
  }

  Container _photo() {
    return Container(
      height: 250,
      width: 340,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('assets/images/IMG_2649.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
