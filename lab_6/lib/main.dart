import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  String str = 'Задайте пареметры';
  int a = 0;
  int b = 0;
  int sum = 0;
  @override
  Widget build(BuildContext context) {
    //return Form( key: _formKey, child: Column());
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0),

            const Text('Ширина (мм):', style: TextStyle(fontSize: 20.0)),
            TextFormField(validator: (value1){
              if(value1!.isEmpty) return 'Задайте Ширину';
              else a = int.parse(value1);
            }),

            const SizedBox(height: 40.0),

            const Text('Высота (мм):', style: TextStyle(fontSize: 20.0)),
            TextFormField(validator: (value2){
              if(value2!.isEmpty) return 'Задайте Высоту';
              else b = int.parse(value2);
            }),

            const SizedBox(height: 40.0),

            ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate())
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Вычисление успешно выполнено'), backgroundColor: Colors.green)
                      );
                    }
                  sum = a * b;
                  str = 'S = $a * $b = $sum (мм2)';
                  setState(() {});
                },
                child: const Text('Вычислить', style: TextStyle(color: Colors.white)),
            ),
            Text(str , style: TextStyle(fontSize: 40.0)),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: const Text("Калькулятор площади")),
          body: const MyForm()),
    ));
