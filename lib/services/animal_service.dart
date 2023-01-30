import 'package:localstorage/localstorage.dart';

enum SelectedAnimal {
  Default,
  Cat,
  Dog
}

const appName = "MainKater.json";

class AnimalService {
  SelectedAnimal GetAnimal() {
    final LocalStorage storage = new LocalStorage(appName);
    dynamic data = storage.getItem('animal');

    if (data == null) {
      storage.setItem('animal', 'cat');
    }

    return data == null || data == "cat" ? SelectedAnimal.Cat : SelectedAnimal.Dog;
  }

  SelectedAnimal SetAnimal(SelectedAnimal animal) {
    final LocalStorage storage = new LocalStorage(appName);
    storage.setItem('animal', animal == SelectedAnimal.Cat ? 'cat' : 'dog');

    return animal;
  }
}