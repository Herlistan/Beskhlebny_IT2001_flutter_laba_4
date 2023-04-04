import 'package:flutter/material.dart';

void main() => runApp(
    new MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()));

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Возвращение значения")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FirstScreen()));
          },
          child: Text('Приступить к выбору'),
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Выберите любой вариант")),
      body: Center(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 260.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Да!'), backgroundColor: Colors.grey)
                  );
                },
                child: Text('Да!'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Нет.'), backgroundColor: Colors.grey)
                  );
                },
                child: Text('Нет.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
