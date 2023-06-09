void main() {
  late final Logistics logistics;
  print(bool.hasEnvironment('LOGISTICS'));
  const logisticsStr = String.fromEnvironment('LOGISTICS');
  print('logistics str: $logisticsStr');
  if (logisticsStr == 'road') {
    logistics = RoadLogistics();
  } else if (logisticsStr == 'sea') {
    logistics = SeaLogistics();
  } else {
    throw UnimplementedError();
  }
  logistics.deliver();
}

abstract class Logistics {
  Transport createTransport() {
    return Truck();
  }

  void deliver() {
    final transport = createTransport();
    transport.deliver();
  }
}

class RoadLogistics extends Logistics {
  @override
  Transport createTransport() {
    return Truck();
  }
}

class SeaLogistics extends Logistics {
  @override
  Transport createTransport() {
    return Ship();
  }
}

abstract interface class Transport {
  void deliver();
}

class Truck implements Transport {
  @override
  void deliver() {
    print('delivering via truck...');
  }
}

class Ship implements Transport {
  @override
  void deliver() {
    print('delivering via ship...');
  }
}
