import 'dart:math';
import 'package:codoc/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:codoc/screens/upload_post_screen.dart';
import 'package:codoc/firebase/firebase_storage.dart';

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
  List<String> imagePaths = [
    'assets/images/documentation_example.PNG',
    'assets/images/documentation_example_2.png',
  ];

  final double horizontalPadding = 24;

  List<String> groupNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: ListTile(
                title: const Text(
                  "Groups",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: groupNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListViewGroupTile(groupName: groupNames[index]);
                },
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              title: const Text(
                'Add group',
                style: TextStyle(fontSize: 12),
              ),
              leading: Icon(
                Icons.add,
                size: 18,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                'Profile settings',
                style: TextStyle(fontSize: 12),
              ),
              leading: Icon(
                Icons.settings,
                size: 18,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),

      /* appBar: AppBar(
        title: const Text('CODOC'),
        centerTitle: true,
      ), */
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('CODOC'),
            centerTitle: true,
            pinned: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _showAddDialog(context);
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Icon(Icons.family_restroom_rounded, size: 96),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SegmentedButton(
                    segments: const <ButtonSegment<ViewType>>[
                      ButtonSegment(
                          value: ViewType.listView,
                          icon: Icon(Icons.view_agenda)),
                      ButtonSegment(
                          value: ViewType.gridView,
                          icon: Icon(Icons.apps_rounded)),
                    ],
                    selected: selection,
                    onSelectionChanged: (Set<ViewType> newSelection) {
                      setState(() {
                        selection = newSelection;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: selection.first == ViewType.listView ? EdgeInsets.all(16.0) : EdgeInsets.all(0.0) ,
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: selection.first == ViewType.listView ? 1 : 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: selection.first == ViewType.listView ? verticalPadding : 1.5,
                mainAxisExtent:
                    selection.first == ViewType.listView ? 500 : 135,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return createCard(selection.first, imagePaths);
                },
                childCount: 40,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyUploadPage(
                title: 'Upload',
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
                    onPressed: () {},
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

  const ListViewGroupTile({
    super.key,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        groupName,
      ),
      onTap: () {
        // TODO: navigate to the corresponding group
      },
    );
  }
}

Widget createCard(ViewType viewType, List<String> imagePaths) {
  switch (viewType) {
    case ViewType.listView:
      return ListViewCard(imagePaths: imagePaths);
    case ViewType.gridView:
      return GridViewCard(imagePaths: imagePaths);
    default:
      // Handle other cases if needed
      return Container();
  }
}

class GridViewCard extends StatelessWidget {
  final List<String> imagePaths;
  final _random = new Random();

  GridViewCard({
    Key? key,
    required this.imagePaths,
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
          Image.asset(
            imagePaths[_random.nextInt(2)],
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  final List<String> imagePaths;

  const ListViewCard({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              itemCount: imagePaths.length,
              pageSnapping: true,
              itemBuilder: (context, pagePosition) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image.asset(
                    imagePaths[pagePosition],
                  ),
                ); //Image.network(images[pagePosition]));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Text(
              'Title',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              '2 aug. 2023',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
