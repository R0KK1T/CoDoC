import 'dart:typed_data';
import 'package:codoc/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
    controllerTitle.addListener(() {
      setState(() {
        isButtonEnabled = controllerTitle.text.isNotEmpty;
      });
    });
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(
      () {
        _image = im;
      },
    );
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
            postChoosePhotoFromGallery(),
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
                children: const [
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

  Widget postChoosePhotoFromGallery() {
    return Stack(
      children: <Widget>[
        Container(
          child: _image != null
              ? Container(
                  height: 250,
                  width: 340,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: MemoryImage(_image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : postUploadImageButton(),
        ),
      ],
    );
  }

  Container postUploadImageButton() {
    
    return Container(
      height: 250,
      width: 340,
      child: IconButton(
        iconSize: 87,
        icon: Icon(Icons.add_a_photo),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List image = await pickImage(ImageSource.camera);
                  setState(() {
                    _image = image;
                  });
                },
                child: const Text('Take picture'),
              ),
              SimpleDialogOption(
                onPressed: selectImage,
                child: const Text('Choose from gallery'),
              ),
            ],
          ),
        ),
        // child: const Text('Show Dialog'),
      ),
    );
  }
}
