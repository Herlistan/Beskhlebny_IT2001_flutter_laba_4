import 'package:flutter/material.dart';
import 'dart:math';

class MyBody extends StatefulWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  createState() => MyBodyState();
}

class MyBodyState extends State<MyBody> {
  final List<String> _array = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, i) {
      print('num $i: нечетное = ${i.isOdd}');
      if(i.isOdd) return Divider();

      final int index = i ~/ 2;

      print('index $index');
      print('lenght ${_array.length}');

      if(index >= _array.length) _array.addAll(['$index', '${index + 1}', '${index + 2}']);
      return ListTile(title: Text(_array[index]),);
    });
  }
}

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Стартовое окно',
            ),
            RawMaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyBody()));
              },
            ),
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
}
