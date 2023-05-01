import 'package:flutter/material.dart';
import 'classes/machine.dart';
import 'classes/resources.dart';
import 'enums.dart';
import 'components/control_panel.dart';
import 'components/display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  Resources resources = Resources(300,300,300,300);
  late Machine machine = Machine(resources);

  int codecoffee = 0;
  void _codecoffee(int value) {
    setState(() {
      codecoffee = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      Display(machine: machine),
      ControlPanel(machine: machine),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Machine'),
        backgroundColor: Colors.brown,
      ),
      body: IndexedStack(
        index: codecoffee,
        children: widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee_maker),
            label: 'Display',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pest_control_sharp),
            label: 'Control Panel',
          ),
        ],
        currentIndex: codecoffee,
        selectedItemColor: Colors.orange,
        onTap: _codecoffee,
      ),
    );
  }
}
