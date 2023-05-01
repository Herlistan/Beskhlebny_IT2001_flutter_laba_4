import 'resources.dart';
import 'icoffeee.dart';
import '../making_coffee.dart';
import 'dart:developer';

class Machine {
  Resources resources;
  Machine(this.resources);

  bool isAvailable(ICoffee icoffee) {
    if (resources.water >= 100 && resources.coffeeBeans >= 50)
      return true;
    else
      return false;
  }
  void subtractResources(ICoffee icoffee){
    resources.coffeeBeans -= icoffee.coffeeBeans();
    resources.milk -= icoffee.milk();
    resources.water -= icoffee.water();
    resources.cash -= icoffee.cash();
  }

  void addResources(int coffee, int milk, int water, int cash) {
    resources.coffeeBeans += coffee;
    resources.milk += milk;
    resources.water += water;
    resources.cash += cash;
  }

  Future<String> makeCoffee(ICoffee icoffee) async {
    if (isAvailable(icoffee)) {
      await boilWater();
      if (icoffee.milk() > 0) {
        await Future.wait([brewCoffee()]);
        await mixMilk();
      }
      else {
        await brewCoffee();
      }
      subtractResources(icoffee);
      String name = icoffee.name();
      log('done_processes: $name');
      return 'Your $name is ready';
    }
    return 'Not enough money';
  }
}


