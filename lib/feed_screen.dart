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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

enum ViewType {listView, gridView}

class _MyHomePageState extends State<MyHomePage> {
  Set<ViewType> selection = {ViewType.listView};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
                  ButtonSegment(value: ViewType.listView, icon: Icon(Icons.view_agenda)),
                  ButtonSegment(value: ViewType.gridView, icon: Icon(Icons.apps_rounded)),
                ],
                selected: selection,
                onSelectionChanged: (Set<ViewType> newSelection){
                  setState(() {
                    selection = newSelection;
                  });
                },
                //multiSelectionEnabled: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Card createCard (){
  return Card(color:Colors.black, child: SizedBox(width: 100, height: 100, child: Text("I am a card!"),));
}