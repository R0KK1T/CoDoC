import 'package:codoc/firebase/firebase_storage.dart';
import 'package:codoc/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddMembersPage extends StatefulWidget {
  const AddMembersPage(
      {super.key, required this.groupName, required this.groupId});
  final String groupName;
  final String groupId;

  @override
  State<StatefulWidget> createState() => _AddMembersPageState();
}

class _AddMembersPageState extends State<AddMembersPage> {
  //List<String> groupMembers = [];
  //String groupTitle = "GroupTitle";
  final double horizontalPadding = 24;
  bool _isLoading = false;
  TextEditingController emailTextController = TextEditingController();
  Stream? groupMembers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingGroupData();
  }

  gettingGroupData() async {
    await StorageMethods().storageGetGroupMembers(widget.groupId).then(
      (snapshot) {
        setState(
          () {
            groupMembers = snapshot;
            //debugPrint("*** ${snapshot.data['members'][0]}");
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.groupName),
        actions: [
          IconButton(
            onPressed: () {
              _showAddDialog(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: groupMembers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['members'].length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data['members'][index]),
                      titleTextStyle:
                          const TextStyle(fontSize: 22, color: Colors.black),
                      leading: Icon(Icons.abc),
                      shape: const Border(bottom: BorderSide()),
                    );
                  });
            } else {
              return Center(
                child: Text("No groupmembers"),
              );
            }
          }),
    );
  }

  void _showAddDialog(BuildContext context) {
    String newMemberEmail = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Add new member'), // Customize dialog title as needed
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: horizontalPadding,
                left: horizontalPadding,
              ),
              child: TextFormField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  //hintText: 'Write group name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: horizontalPadding, top: horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      newMemberEmail = emailTextController.text;
                      if (newMemberEmail != "") {
                        setState(
                          () {
                            _isLoading = true;
                          },
                        );
                        String? userId = await StorageMethods()
                            .getUserByEmail(newMemberEmail);
                        StorageMethods()
                            .storageAddUserToGroup(
                                userId!, widget.groupId, widget.groupName)
                            .whenComplete(
                          () {
                            _isLoading = false;
                          },
                        );
                        Navigator.of(context).pop();
                        showSnackBar(context, "User added successfully.");
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
