import 'package:flutter/material.dart';
import 'dart:developer';

Future<void> boilWater() async {
  log('start_process: boilWater');
  await Future.delayed(const Duration(seconds: 10), () => log('done_process: boilWater'));
}
Future<void> brewCoffee() async {
  log('start_process: brewCoffee');
  await Future.delayed(const Duration(seconds: 5), () => log('done_process: brewCoffee'));
}
Future<void> mixMilk() async {
  log('start_process: mixMilk');
  await Future.delayed(const Duration(seconds: 4), () => log('done_process: mixMilk'));
}