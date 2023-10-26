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
    super.initState();
    gettingGroupData();
  }

  gettingGroupData() async {
    await StorageMethods().storageGetGroupMembers(widget.groupId).then(
      (snapshot) {
        setState(
          () {
            groupMembers = snapshot;
          },
        );
      },
    );
  }

  String getUserName(String name) {
    return name.substring(name.indexOf("_") + 1);
  }

  String getUserId(String name) {
    return name.substring(0, name.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
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
                String userInfo = snapshot.data['members'][index];
                return FutureBuilder<String?>(
                  future: getProfilePicture(userInfo),
                  builder: (context, pictureSnapshot) {
                    if (pictureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Or some loading indicator
                    } else if (pictureSnapshot.hasError) {
                      return Text('Error loading profile picture');
                    } else if (pictureSnapshot.hasData &&
                        pictureSnapshot.data != null) {
                      String userImage = pictureSnapshot.data!;
                      return ListTile(
                        title: Text(getUserName(userInfo)),
                        titleTextStyle:
                            const TextStyle(fontSize: 22, color: Colors.black),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(userImage),
                        ),
                      );
                    } else {
                      return Text('No profile picture available');
                    }
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text("No members in group"),
            );
          }
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    String newMemberEmail = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Add new member'),
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
                        String? userName =
                            await StorageMethods().getUserNameById(userId!);
                        StorageMethods()
                            .storageAddUserToGroup(userId, userName!,
                                widget.groupId, widget.groupName)
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

  Future<String?> getProfilePicture(String userInfo) async {
    String userId = getUserId(userInfo);
    return await StorageMethods().getProfilePictureById(userId);
  }
}
