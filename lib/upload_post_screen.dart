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
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    controllerTitle.addListener(() {
      setState(() {
        isButtonEnabled = controllerTitle.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Create Post"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            _photo(),
            Padding(padding: EdgeInsets.only(bottom: 26)),

// --------- Add more than one photo ---------
            // Padding(
            //   padding: const EdgeInsets.only(left: 26, right: 208, bottom: 26),
            //   child: FilledButton.tonal(
            //     onPressed: () {},
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const <Widget>[
            //         Icon(Icons.add_a_photo),
            //         SizedBox(width: 8),
            //         Text('Add photo'),
            //       ],
            //     ),
            //   ),
            // ),
// --------- Add more than one photo ---------

            _textFieldTitle(controllerTitle),
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("* mandatory"),
                ],
              ),
            ), //Align to left
            Padding(padding: EdgeInsets.only(bottom: 26)),
            _textFieldDescription(controllerDescription),
            Padding(padding: EdgeInsets.only(bottom: 26)),
            Padding(
              padding: const EdgeInsets.only(bottom: 26),
              child: FilledButton(
                onPressed: controllerTitle.text.isNotEmpty ? () {} : null,
                child: const Text('Upload'),
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
          labelText: "Title*",
        ),
      ),
    );
  }

  Padding _textFieldDescription(controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 26, right: 26),
      child: TextField(
        maxLines: 3,
        maxLength: 140,
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
        // borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('assets/images/IMG_2649.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
