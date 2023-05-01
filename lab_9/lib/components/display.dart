import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../classes/machine.dart';
import '../classes/kindOfCoffee.dart';

class Display extends StatefulWidget {
  final Machine machine;
  final Espresso espresso = Espresso();
  final Makiato makiato = Makiato();
  final Breve breve = Breve();
  final KonYelo konyelo = KonYelo();
  Display({Key? key, required this.machine}) : super(key: key);

  @override
  State<Display> createState() => _Display();
}

class _Display extends State<Display> {
  var _coffee;
  String _progress = 'Coffee Maker';
  bool _brewing = false;
  TextEditingController cashController = TextEditingController();

  void _brewCoffee() async {
    _setBrewing(true);
    _hints();
    _progress = await widget.machine.makeCoffee(_coffee);
    _setBrewing(false);
  }

  void _hints() async {
    _progress = 'Boiling the water';
    setState(() {
    });
    await Future.delayed(const Duration(seconds:3), () => _progress = 'Brewing the coffee');
    setState(() {
    });
    if (_coffee.milk() > 0) {
      await Future.delayed(
          const Duration(seconds: 5), () => _progress = 'Mixing the milk');
      setState(() {});
    }
  }

  void _setBrewing(bool brewing) {
    setState(() {
      _brewing = brewing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
                children: [
                  ColoredBox(color: Colors.lime, child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20,20,0,10),
                          child: Column(
                              children:[
                                Text('Beans: ${widget.machine.resources.coffeeBeans}'),
                                Text('Milk: ${widget.machine.resources.milk}'),
                                Text('Water: ${widget.machine.resources.water}'),
                              ]
                          )),

                    Align(
                        alignment: Alignment.center,
                        child: ColoredBox(
                            color: Colors.lime.shade100,
                            child: Padding(
                                padding: const EdgeInsets.all(70.0),
                                child: Column(
                                  children: [
                                    Text(
                                        _progress,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 25),
                                        textAlign: TextAlign.center),
                                    SizedBox(height: 30),
                                    Text('Your money: ${widget.machine.resources.cash}', style: TextStyle(
                                        fontWeight: FontWeight.w300, fontSize: 18),
                                        textAlign: TextAlign.center),
                                  ],
                                )

                            )
                        )
                    ),
                    const Padding(padding: EdgeInsets.all(20.0))
                  ],)),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(child:
                        Column(children: <Widget>[
                          ListTile(
                            title: const Text('Espresso: ₽90'),
                            leading: Radio(
                              value: widget.espresso,
                              groupValue: _coffee,
                              onChanged: (value) {
                                setState(() {
                                  _coffee = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Makiato: ₽100'),
                            leading: Radio(
                              value: widget.makiato,
                              groupValue: _coffee,
                              onChanged: (value) {
                                setState(() {
                                  _coffee = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Breve: ₽110'),
                            leading: Radio(
                              value: widget.breve,
                              groupValue: _coffee,
                              onChanged: (value) {
                                setState(() {
                                  _coffee = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('KonYelo: ₽120'),
                            leading: Radio(
                              value: widget.konyelo,
                              groupValue: _coffee,
                              onChanged: (value) {
                                setState(() {
                                  _coffee = value;
                                });
                              },
                            ),
                          ),
                        ])),
                        Align(child:
                        Padding(padding: const EdgeInsets.all(20.0), child:
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                            onPressed: (_brewing || _coffee == null) ? null : _brewCoffee,
                            child: Icon(Icons.play_arrow)
                        ))
                        )
                      ]
                  ),
                  Row(children: [
                    Expanded(child:
                    Padding(padding: const EdgeInsets.fromLTRB(30,0,30,0), child:
                    TextField(
                      controller: cashController,
                      decoration: const InputDecoration(
                          hintText: 'Put money here'
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9]")),
                      ],
                      onChanged: (value) {
                        setState(() {});
                      },
                    ))
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(10,0,10,0), child:
                    ElevatedButton(
                        onPressed: cashController.text.isEmpty ? null : () =>
                            setState(() {
                              widget.machine.addResources(0, 0, 0, int.parse(cashController.text));
                            })
                        ,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Icon(Icons.add))),
                    Padding(padding: const EdgeInsets.fromLTRB(10,0,10,0), child:
                    ElevatedButton(
                        onPressed: cashController.text.isEmpty ? null : () =>
                            setState(() {
                              widget.machine.addResources(0, 0, 0, -int.parse(cashController.text));
                            })
                        ,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                        child: const Icon(Icons.remove)))
                  ],
                  )
                ]
            )
        )
    );
  }
}