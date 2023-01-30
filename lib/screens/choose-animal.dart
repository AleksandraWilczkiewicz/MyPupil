import 'package:alewilapp/components/choose-animal-action.dart';
import 'package:alewilapp/screens/main-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../services/animal_service.dart';

class ChooseAnimalWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChooseAnimalWidgetState();
  }
}

class _ChooseAnimalWidgetState extends State<ChooseAnimalWidget> {
  SelectedAnimal _selectedAnimal = SelectedAnimal.Default;

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => MainScreenWidget()));
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Visibility(
                  visible: _selectedAnimal == SelectedAnimal.Cat ||
                      _selectedAnimal == SelectedAnimal.Default,
                  child: ChooseAnimalActionWidget("KOT",
                      FontAwesome5.cat, SelectedAnimal.Cat, (animal) {
                    if (_selectedAnimal == animal) {
                      return;
                    }

                    setState(() {
                      _selectedAnimal = animal;
                    });

                    AnimalService().SetAnimal(animal);

                    Future.delayed(const Duration(milliseconds: 500), () {
                      _navigateToNextScreen(context);
                      setState(() {
                        _selectedAnimal = SelectedAnimal.Default;
                      });
                    });
                  }, Colors.pink[100]!)),
              Visibility(
                visible: _selectedAnimal == SelectedAnimal.Dog ||
                    _selectedAnimal == SelectedAnimal.Default,
                child: ChooseAnimalActionWidget(
                    "PIES", FontAwesome5.dog, SelectedAnimal.Dog, (animal) {
                  if (_selectedAnimal == animal) {
                    return;
                  }

                  setState(() {
                    _selectedAnimal = animal;
                  });

                  AnimalService().SetAnimal(animal);

                  Future.delayed(const Duration(milliseconds: 500), () {
                    _navigateToNextScreen(context);
                    setState(() {
                      _selectedAnimal = SelectedAnimal.Default;
                    });
                  });
                }, Colors.blue[200]!),
              )
            ]),
          ],
        )));
  }
}

// Stack(
// children: [
// Container(
// child: Column(
// children: <Widget>[
// Text("Wybierz zwierzę:"),
// ListTile(
// title: const Text('Kot'),
// leading: Radio<SelectedAnimal>(
// value: SelectedAnimal.Cat,
// groupValue: _selectedAnimal,
// onChanged: (SelectedAnimal? value) {
// setState(() {
// _selectedAnimal = value;
// });
// AnimalService().SetAnimal(SelectedAnimal.Cat);
// _navigateToNextScreen(context);
// },
// ),
// ),
// ListTile(
// title: const Text('Pies'),
// leading: Radio<SelectedAnimal>(
// value: SelectedAnimal.Dog,
// groupValue: _selectedAnimal,
// onChanged: (SelectedAnimal? value) {
// setState(() {
// _selectedAnimal = value;
// });
// AnimalService().SetAnimal(SelectedAnimal.Dog);
// _navigateToNextScreen(context);
// },
// ),
// ),
// ],
// ),
// ),
// ],
// ),
