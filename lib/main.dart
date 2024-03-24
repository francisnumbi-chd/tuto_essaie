import 'dart:io';

import 'package:collection_ext/all.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuto_essaie/tabling_widget.dart';

import 'human.dart';
import 'local_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        //primarySwatch: Colors.blue,
        colorSchemeSeed: Colors.blue,
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late List<Human> people;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  late bool isAuthenticated = false;

  @override
  void initState() {
    Faker faker = Faker();
    people = List.generate(20, (index) {
      return Human(
        name: faker.person.name(),
        sex: faker.person.random.element(["Male", "Female"]),
        age: faker.person.random.integer(50, min: 13).toString(),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isAndroid
          ? AppBar(
              title: Text(widget.title),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: MenuBar(children: [
                    SubmenuButton(menuChildren: [
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.add),
                        shortcut: const SingleActivator(LogicalKeyboardKey.keyN,
                            control: true),
                        child: const Text("New"),
                        onPressed: () {
                          _showDialog("New");
                        },
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.folder_open_outlined),
                        shortcut: const SingleActivator(LogicalKeyboardKey.keyO,
                            control: true),
                        child: const Text("Open"),
                        onPressed: () {
                          _showDialog("Open");
                        },
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.save),
                        shortcut: const SingleActivator(LogicalKeyboardKey.keyS,
                            control: true),
                        child: const Text("Save"),
                        onPressed: () {
                          _showDialog("Save");
                        },
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.save_as),
                        shortcut: const SingleActivator(LogicalKeyboardKey.keyN,
                            control: true, shift: true),
                        child: const Text("Save As..."),
                        onPressed: () {
                          _showDialog("Save As...");
                        },
                      ),
                      const MenuItemButton(
                        leadingIcon: Icon(Icons.close),
                        shortcut: SingleActivator(LogicalKeyboardKey.escape),
                        child: Text("Close"),
                      ),
                    ], child: const Text("File")),
                    const SubmenuButton(menuChildren: [
                      MenuItemButton(
                        leadingIcon: Icon(Icons.undo),
                        shortcut: SingleActivator(LogicalKeyboardKey.keyZ,
                            control: true),
                        child: Text("Undo"),
                      ),
                      MenuItemButton(
                        leadingIcon: Icon(Icons.redo),
                        shortcut: SingleActivator(LogicalKeyboardKey.keyZ,
                            control: true, shift: true),
                        child: Text("Redo"),
                      ),
                      MenuItemButton(
                        leadingIcon: Icon(Icons.cut),
                        shortcut: SingleActivator(LogicalKeyboardKey.keyX,
                            control: true),
                        child: Text("Cut"),
                      ),
                      MenuItemButton(
                        leadingIcon: Icon(Icons.copy),
                        shortcut: SingleActivator(LogicalKeyboardKey.keyC,
                            control: true),
                        child: Text("Copy"),
                      ),
                      MenuItemButton(
                        leadingIcon: Icon(Icons.paste),
                        shortcut: SingleActivator(LogicalKeyboardKey.keyV,
                            control: true),
                        child: Text("Paste"),
                      ),
                    ], child: Text("Edit")),
                  ]),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child:
                  Text(isAuthenticated ? "Authenticated" : "Not Authenticated"),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final authenticate = await LocalAuth.authenticate();
                  setState(() {
                    isAuthenticated = authenticate;
                  });
                },
                child: const Text("Authenticate"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TablingWidget(
                  header: TableRow(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: const Center(
                            child: Text(
                          '#',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: const Center(
                            child: Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: const Center(
                            child: Text(
                          'Sex',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: const Center(
                            child: Text(
                          'Age',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )),
                      ),
                    ],
                  ),
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(40.0),
                    1: FlexColumnWidth(2.0),
                    2: FlexColumnWidth(0.7),
                    3: FlexColumnWidth(0.5),
                  },
                  rows: people.mapIndexed((i, human) {
                    return TableRow(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("${i + 1}")),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Text(human.name),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Center(child: Text(human.sex)),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(human.age)),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            // const Expanded(child: DataTablingWidget()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDialog(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert Dialog title"),
          content: Text("You pressed the \"$text\" button"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
