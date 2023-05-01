import 'icoffeee.dart';

class Espresso implements ICoffee {
  @override
  String name() => "Espresso";
  @override
  int coffeeBeans() => 100;
  @override
  int milk() => 0;
  @override
  int water() => 50;
  @override
  int cash() => 90;
}

class Makiato implements ICoffee {
  @override
  String name() => "Makiato";
  @override
  int coffeeBeans() => 150;
  @override
  int milk() => 70;
  @override
  int water() => 0;
  @override
  int cash() => 100;
}

class Breve implements ICoffee {
  @override
  String name() => "Breve";
  @override
  int coffeeBeans() => 150;
  @override
  int milk() => 100;
  @override
  int water() => 0;
  @override
  int cash() => 110;
}
class KonYelo implements ICoffee {
  @override
  String name() => "KonYelo";
  @override
  int coffeeBeans() => 50;
  @override
  int milk() => 0;
  @override
  int water() => 100;
  @override
  int cash() => 120;
}
