import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../classes/machine.dart';
import '../classes/kindOfCoffee.dart';

class ControlPanel extends StatefulWidget {
  final Machine machine;
  const ControlPanel({Key? key, required this.machine}) : super(key: key);


  @override
  State<ControlPanel> createState() => _ControlPanel();
}

class _ControlPanel extends State<ControlPanel> {
  TextEditingController cbController = TextEditingController();
  TextEditingController waterController = TextEditingController();
  TextEditingController milkController = TextEditingController();
  TextEditingController cashController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
                children: [
                  ColoredBox(color: Colors.lime,
                      child: Column(children: [
                        SizedBox(height: 20),
                        Align(
                            alignment: Alignment.center,
                            child: ColoredBox(
                                color: Colors.lime.shade100,
                                child: Padding(
                                    padding: EdgeInsets.fromLTRB(90,5,90,35),
                                    child: Column(
                                        children: [
                                          Text(
                                              'Resources: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 36),
                                              textAlign: TextAlign.center),
                                          SizedBox(height: 30),
                                          Text('Coffee Beans: ${widget.machine
                                              .resources.coffeeBeans}',
                                              style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20),
                                    textAlign: TextAlign.center),
                                          Text('Milk: ${widget.machine.resources
                                              .milk}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20),),
                                          Text(
                                              'Water: ${widget.machine.resources
                                                  .water}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20),),
                                          Text('Cash: ${widget.machine.resources
                                              .cash}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20),),
                                        ]
                                    )
                                )
                            )
                        ),
                        const Padding(padding: EdgeInsets.all(20.0))
                      ],)),
                  Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(padding: const EdgeInsets.fromLTRB(30,0,30,0), child:
                        TextField(
                          controller: cbController,
                          decoration: const InputDecoration(
                              hintText: 'put beans'
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9]")),
                          ],
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),),

                        Padding(padding: const EdgeInsets.fromLTRB(30,0,30,0), child:
                        TextField(
                          controller: waterController,
                          decoration: const InputDecoration(
                              hintText: 'put water'
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9]")),
                          ],
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),),

                        Padding(padding: const EdgeInsets.fromLTRB(30,0,30,0), child:
                        TextField(
                          controller: milkController,
                          decoration: const InputDecoration(
                              hintText: 'put milk'
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9]")),
                          ],
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),),

                        Padding(padding: const EdgeInsets.fromLTRB(30,0,30,0), child:
                        TextField(
                          controller: cashController,
                          decoration: const InputDecoration(
                              hintText: 'put cash'
                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9]")),
                          ],
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(padding: const EdgeInsets.fromLTRB(10,20,0,20), child:
                            ElevatedButton(
                                onPressed: cashController.text.isEmpty ? null : () =>
                                    setState(() {
                                      widget.machine.addResources(
                                          int.parse(cbController.text),
                                          int.parse(waterController.text),
                                          int.parse(milkController.text),
                                          int.parse(cashController.text));
                                    })
                                ,
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                                child: const Icon(Icons.add))),
                            Padding(padding: const EdgeInsets.fromLTRB(10,20,10,20), child:
                            ElevatedButton(
                                onPressed: cashController.text.isEmpty ? null : () =>
                                    setState(() {
                                      widget.machine.addResources(
                                          -int.parse(cbController.text),
                                          -int.parse(waterController.text),
                                          -int.parse(milkController.text),
                                          -int.parse(cashController.text));
                                    })
                                ,
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                child: const Icon(Icons.remove)))
                          ],
                        )
                      ]
                  )
                ]
            )
        )
    );
  }
}