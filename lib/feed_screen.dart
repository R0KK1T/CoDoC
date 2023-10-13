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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ViewType { listView, gridView }

class _MyHomePageState extends State<MyHomePage> {
  Set<ViewType> selection = {ViewType.listView};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
      appBar: AppBar(
        title: const Text('CODOC'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Icon(Icons.family_restroom_rounded, size: 96),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SegmentedButton(
                segments: const <ButtonSegment<ViewType>>[
                  ButtonSegment(
                      value: ViewType.listView, icon: Icon(Icons.view_agenda)),
                  ButtonSegment(
                      value: ViewType.gridView, icon: Icon(Icons.apps_rounded)),
                ],
                selected: selection,
                onSelectionChanged: (Set<ViewType> newSelection) {
                  setState(() {
                    selection = newSelection;
                  });
                },
                //multiSelectionEnabled: true,
              ),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: selection.first == ViewType.listView ? 1 : 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  mainAxisExtent:
                      selection.first == ViewType.listView ? 500 : 135,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return createCard(selection.first);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Container createCard(ViewType viewType) {
  switch (viewType) {
    case ViewType.listView:
      return ListViewCard();
    case ViewType.gridView:
      return GridViewCard();
  }
}

class GridViewCard extends Container {
  GridViewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/documentation_example.PNG',
    );
  }
}

class ListViewCard extends Container {
  ListViewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
                itemCount: 2,
                pageSnapping: true,
                itemBuilder: (context, pagePosition) {
                  return Container(
                      //margin: EdgeInsets.all(5),
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        'assets/images/documentation_example.PNG',
                      )); //Image.network(images[pagePosition]));
                }),
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
