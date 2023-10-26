import 'package:codoc/utils/utils.dart';
import 'package:flutter/material.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({super.key});

  @override
  State<MySettingsPage> createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  bool light = false;
  bool noti = true;
  MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>((Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.check);
    }
    return const Icon(Icons.close);
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Center(
        // child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: ListTile(
              title: Text("Dark Mode"),
              trailing: Switch(
                thumbIcon: thumbIcon,
                value: light,
                onChanged: (bool value) {
                  setState(() {
                    //light = value;
                    showSnackBar(context,
                        'You have to be a member of CoLog Premium to use this feature');
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: Text("Notifications"),
            trailing: Switch(
              thumbIcon: thumbIcon,
              value: noti,
              onChanged: (bool value) {
                setState(() {
                  noti = value;
                });
              },
            ),
          ),
        ]),
      ),
    );
  }
}
