void main() {
  final director = Director();

  CarBuilder builder = CarBuilder();
  director.constructSportsCar(builder);

  Car car = builder.getResult();
  print('Car build:\n${car.carType}');

  CarManualBuilder manualBuilder = CarManualBuilder();

  director.constructSportsCar(manualBuilder);
  Manual carManual = manualBuilder.getResult();
  print('\nCar manual build:\n${carManual.print()}');
}

final class Director {
  void constructSportsCar(Builder builder) {
    builder.setCarType(CarType.sportsCar);
    builder.setSeats(2);
    builder.setEngine(Engine(3.0, 0));
    builder.setTransmission(Transmission.semiAutomatic);
    builder.setTripComputer(TripComputer());
    builder.setGPSNavigator(GPSNavigator());
  }

  void constructCityCar(Builder builder) {
    builder.setCarType(CarType.cityCar);
    builder.setSeats(2);
    builder.setEngine(Engine(1.2, 0));
    builder.setTransmission(Transmission.automatic);
    builder.setTripComputer(TripComputer());
    builder.setGPSNavigator(GPSNavigator());
  }

  void constructSUV(Builder builder) {
    builder.setCarType(CarType.suv);
    builder.setSeats(4);
    builder.setEngine(Engine(2.5, 0));
    builder.setTransmission(Transmission.manual);
    builder.setGPSNavigator(GPSNavigator());
  }
}

abstract interface class Builder {
  void setCarType(CarType type);

  void setSeats(int seats);

  void setEngine(Engine engine);

  void setTransmission(Transmission transmission);

  void setTripComputer(TripComputer tripComputer);

  void setGPSNavigator(GPSNavigator gpsNavigator);
}

final class CarBuilder implements Builder {
  CarType? _carType;
  int? _seats;
  Engine? _engine;
  Transmission? _transmission;
  TripComputer? _tripComputer;
  GPSNavigator? _gpsNavigator;

  @override
  void setCarType(CarType type) {
    _carType = type;
  }

  @override
  void setEngine(Engine engine) {
    _engine = engine;
  }

  @override
  void setGPSNavigator(GPSNavigator gpsNavigator) {
    _gpsNavigator = gpsNavigator;
  }

  @override
  void setSeats(int seats) {
    _seats = seats;
  }

  @override
  void setTransmission(Transmission transmission) {
    _transmission = transmission;
  }

  @override
  void setTripComputer(TripComputer tripComputer) {
    _tripComputer = tripComputer;
  }

  Car getResult() {
    return Car(
        _carType, _seats, _engine, _transmission, _tripComputer, _gpsNavigator);
  }
}

final class CarManualBuilder implements Builder {
  CarType? _carType;
  int? _seats;
  Engine? _engine;
  Transmission? _transmission;
  TripComputer? _tripComputer;
  GPSNavigator? _gpsNavigator;

  @override
  void setCarType(CarType type) {
    _carType = type;
  }

  @override
  void setEngine(Engine engine) {
    _engine = engine;
  }

  @override
  void setGPSNavigator(GPSNavigator gpsNavigator) {
    _gpsNavigator = gpsNavigator;
  }

  @override
  void setSeats(int seats) {
    _seats = seats;
  }

  @override
  void setTransmission(Transmission transmission) {
    _transmission = transmission;
  }

  @override
  void setTripComputer(TripComputer tripComputer) {
    _tripComputer = tripComputer;
  }

  Manual getResult() {
    return Manual(
        _carType, _seats, _engine, _transmission, _tripComputer, _gpsNavigator);
  }
}

final class Car {
  late final CarType? _carType;
  late final int? _seats;
  late final Engine? _engine;
  late final Transmission? _transmission;
  late final TripComputer? _tripComputer;
  late final GPSNavigator? _gpsNavigator;
  late double fuel;

  Car(CarType? carType, int? seats, Engine? engine, Transmission? transmission,
      TripComputer? tripComputer, GPSNavigator? gpsNavigator,
      [this.fuel = 0]) {
    _carType = carType;
    _seats = seats;
    _engine = engine;
    _transmission = transmission;
    _tripComputer = tripComputer;
    _gpsNavigator = gpsNavigator;
    if (_tripComputer != null) {
      _tripComputer!.setCar(this);
    }
  }

  CarType get carType => _carType!;

  int get seats => _seats!;

  Engine get engine => _engine!;

  Transmission get transmission => _transmission!;

  TripComputer? get tripComputer => _tripComputer;

  GPSNavigator? get gpsNavigator => _gpsNavigator;
}

final class Manual {
  late final CarType? _carType;
  late final int? _seats;
  late final Engine? _engine;
  late final Transmission? _transmission;
  late final TripComputer? _tripComputer;
  late final GPSNavigator? _gpsNavigator;

  Manual(
      CarType? carType,
      int? seats,
      Engine? engine,
      Transmission? transmission,
      TripComputer? tripComputer,
      GPSNavigator? gpsNavigator) {
    _carType = carType;
    _seats = seats;
    _engine = engine;
    _transmission = transmission;
    _tripComputer = tripComputer;
    _gpsNavigator = gpsNavigator;
  }

  String print() {
    String info = '';
    info += 'Type of car: $_carType\n';
    info += 'Count of seats: $_seats\n';
    info +=
        'Engine: volume - ${_engine?.volume}; mileage - ${_engine?.mileage}\n';
    info += 'Transmission: $_transmission\n';
    if (_tripComputer != null) {
      info += 'Trip Computer: Functional\n';
    } else {
      info += 'Trip Computer: N/A\n';
    }
    if (_gpsNavigator != null) {
      info += 'GPS Navigator: Functional\n';
    } else {
      info += 'GPS Navigator: N/A\n';
    }
    return info;
  }
}

enum CarType { suv, cityCar, sportsCar }

final class Engine {
  late final double _volume;
  late double _mileage;
  late bool _started;

  Engine(double volume, double mileage) {
    _volume = volume;
    _mileage = mileage;
  }

  void on() {
    _started = true;
  }

  void off() {
    _started = false;
  }

  bool get isStarted => _started;

  void go(double mileage) {
    if (_started) {
      _mileage += mileage;
    } else {
      throw Exception('Cannot go(), you must start engine first!');
    }
  }

  double get volume => _volume;

  double get mileage => _mileage;
}

enum Transmission { semiAutomatic, automatic, manual }

final class TripComputer {
  late Car _car;

  void setCar(Car car) {
    _car = car;
  }

  void showFuelLevel() {
    print('Fuel level: ${_car.fuel}');
  }

  void showStatus() {
    if (_car.engine.isStarted) {
      print('Car is started');
    } else {
      print('Car isn\'t started');
    }
  }
}

final class GPSNavigator {
  late String route;

  GPSNavigator.manualRoute(this.route);

  factory GPSNavigator() {
    return GPSNavigator.manualRoute(
        '221b, Baker Street, London to Scotland Yard, 8-10 Broadway, London');
  }
}
