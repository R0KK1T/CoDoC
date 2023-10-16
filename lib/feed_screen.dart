import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
        imagePaths: [
          'assets/images/documentation_example.PNG',
          'assets/images/documentation_example_2.PNG'
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.imagePaths});

  final String title;
  final List<String> imagePaths;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Item 1'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    title: const Text('Item 2'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ],
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
            ),
            ListTile(
              title: const Text(
                'Add project log',
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
            backgroundColor: Colors.lightGreen,
            centerTitle: true,
            pinned: true, // App bar will be pinned to the top
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
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: selection.first == ViewType.listView ? 1 : 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              mainAxisExtent: selection.first == ViewType.listView ? 500 : 135,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return createCard(selection.first, imagePaths);
              },
              childCount: 15,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Create post',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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

  const GridViewCard({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: imagePaths.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        String imagePath = imagePaths[index];
        return Image.asset(
          imagePath,
          fit: BoxFit.cover,
        );
      },
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
                return SizedBox(
                  //margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
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
