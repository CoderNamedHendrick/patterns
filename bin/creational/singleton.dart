void main() {
  Singleton singleton = Singleton.getInstance('FOO');
  Singleton anotherSingleton = Singleton.getInstance('BAR');

  print(singleton.value);
  print(anotherSingleton.value);
}

final class Singleton {
  static Singleton? _instance;
  String? value;

  Singleton._(this.value);

  static Singleton getInstance(String? value) {
    return _instance ??= Singleton._(value);
  }
}
