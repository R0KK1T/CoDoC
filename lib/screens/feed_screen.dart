import 'dart:typed_data';

import 'package:codoc/screens/add_members_screen.dart';
import 'package:codoc/screens/profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:codoc/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:codoc/screens/upload_post_screen.dart';
import 'package:codoc/firebase/firebase_storage.dart';
import 'package:codoc/firebase/firebase_authentication.dart';
import 'package:codoc/screens/settings_screen.dart';
import 'package:codoc/utils/utils.dart';

class MyHomePage extends StatefulWidget {
  final String groupName;
  final String groupId;

  const MyHomePage({
    super.key,
    required this.groupName,
    required this.groupId,
  });

  //final List<String> imagePaths;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ViewType { listView, gridView }

class _MyHomePageState extends State<MyHomePage> {
  Set<ViewType> selection = {ViewType.listView};

  final double horizontalPadding = 24;
  TextEditingController groupNameTextController = TextEditingController();

  List<String> groupNames = [];
  bool _isLoading = false;
  AuthMethods authService = AuthMethods();
  Stream? groups;
  Stream? groupPosts;
  String userId = "";
  String? userName = "";
  String? profImg;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    // getting the list of snapshots in our stream
    userId = FirebaseAuth.instance.currentUser!.uid;
    userName = await StorageMethods().getUserNameById(userId);
    profImg = await StorageMethods().getProfilePictureById(userId);

    await StorageMethods(uid: FirebaseAuth.instance.currentUser!.uid)
        .storageGetUserGroups()
        .then(
      (snapshot) {
        setState(
          () {
            groups = snapshot;
          },
        );
      },
    );
    await StorageMethods().storageGetPosts(widget.groupId).then(
      (snapshot) {
        setState(
          () {
            groupPosts = snapshot;
            debugPrint('*** ${groupPosts.toString()}');
          },
        );
      },
    );
  }

  String getGroupId(String name) {
    return name.substring(0, name.indexOf("_"));
  }

  String getGroupName(String name) {
    return name.substring(name.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: ListTile(
                title: Text(userName!),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProfilePage(
                        userId: userId,
                        userName: userName!,
                        profImg: profImg!,
                      ),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: const Text(
                "Groups",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: groups,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data['groups'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListViewGroupTile(
                          groupName: getGroupName(
                            snapshot.data['groups'][index],
                          ),
                          groupId: getGroupId(
                            snapshot.data['groups'][index],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No groups',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              title: const Text(
                'Create group',
                style: TextStyle(fontSize: 14),
              ),
              leading: Icon(
                Icons.add,
                size: 18,
              ),
              onTap: () {
                // Update the state of the app.
                _showAddDialog(context);
              },
            ),
            ListTile(
              title: const Text(
                'Settings',
                style: TextStyle(fontSize: 14),
              ),
              leading: Icon(
                Icons.settings,
                size: 18,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MySettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Sign out',
                style: TextStyle(fontSize: 14),
              ),
              leading: Icon(
                Icons.logout,
                size: 18,
              ),
              onTap: () {
                authService.authUserSignOut();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: ((context) => const MyLoginScreen()),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: groupPosts,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text(widget.groupName),
                      centerTitle: true,
                      pinned: true,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.group_add),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddMembersPage(
                                          groupId: widget.groupId,
                                          groupName: widget.groupName,
                                        )));
                          },
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SegmentedButton(
                              segments: const <ButtonSegment<ViewType>>[
                                ButtonSegment(
                                  value: ViewType.listView,
                                  icon: Icon(Icons.view_agenda),
                                ),
                                ButtonSegment(
                                  value: ViewType.gridView,
                                  icon: Icon(Icons.apps_rounded),
                                ),
                              ],
                              selected: selection,
                              onSelectionChanged: (Set<ViewType> newSelection) {
                                setState(
                                  () {
                                    selection = newSelection;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: selection.first == ViewType.listView
                          ? EdgeInsets.all(16.0)
                          : EdgeInsets.all(0.0),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              selection.first == ViewType.listView ? 1 : 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: selection.first == ViewType.listView
                              ? horizontalPadding
                              : 1.5,
                          mainAxisExtent:
                              selection.first == ViewType.listView ? 500 : 135,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            debugPrint(snapshot.toString());
                            return createCard(
                              selection.first,
                              snapshot.data.docs[index],
                            );
                          },
                          childCount: snapshot.data.docs.length,
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'No groups',
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyUploadPage(
                groupId: widget.groupId,
              ),
            ),
          );
        },
        tooltip: 'Create post',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    String createNewGroupName = "";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Create new group'), // Customize dialog title as needed
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                right: horizontalPadding,
                left: horizontalPadding,
              ),
              child: TextFormField(
                controller: groupNameTextController,
                decoration: const InputDecoration(
                  labelText: 'Group name',
                  hintText: 'Write group name',
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
                      createNewGroupName = groupNameTextController.text;
                      if (createNewGroupName != "") {
                        setState(
                          () {
                            _isLoading = true;
                          },
                        );
                        String? userName = await StorageMethods()
                            .getUserNameById(
                                FirebaseAuth.instance.currentUser!.uid);
                        StorageMethods(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .storageCreateGroup(
                                FirebaseAuth.instance.currentUser!.uid,
                                userName!,
                                createNewGroupName)
                            .whenComplete(
                          () {
                            _isLoading = false;
                          },
                        );
                        Navigator.of(context).pop();
                        showSnackBar(context, "Group created successfully.");
                      }
                    },
                    child: Text('Create'),
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

class ListViewGroupTile extends StatelessWidget {
  final String groupName;
  final String groupId;

  const ListViewGroupTile({
    Key? key, // Add the 'key' parameter here
    required this.groupName,
    required this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        groupName,
      ),
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                MyHomePage(groupName: groupName, groupId: groupId),
          ),
          (route) => false,
        );
      },
    );
  }
}

Widget createCard(ViewType viewType, dynamic snapshot) {
  switch (viewType) {
    case ViewType.listView:
      return ListViewCard(post: snapshot);
    case ViewType.gridView:
      return GridViewCard(post: snapshot);
    default:
      // Handle other cases if needed
      return Container();
  }
}

class GridViewCard extends StatelessWidget {
  final dynamic post;

  const GridViewCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1),
      width: 200,
      height: 200,
      child: GridView.count(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        children: [
          Image.network(post.data()["postUrl"]),
        ],
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  final dynamic post;

  const ListViewCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              itemCount: 1,
              pageSnapping: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image.network(post.data()["postUrl"]),
                ); //Image.network(images[pagePosition]));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Text(
              post
                  .data()["title"]
                  .toString(), //'title', //post["title"].toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              DateFormat(
                'dd MMM yyyy HH:mm',
              ).format(
                DateTime.fromMillisecondsSinceEpoch(
                  post.data()["datePublished"],
                ),
              ),
              //.toString(), //'date', //post["datePublished"].toString(),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post
                  .data()["description"]
                  .toString(), //'desc.', //post["description"].toString(),
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
