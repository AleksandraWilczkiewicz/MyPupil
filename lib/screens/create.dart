import 'package:alewilapp/components/create-row.dart';
import 'package:alewilapp/domain/action-type.dart';
import 'package:alewilapp/screens/create-action.dart';
import 'package:alewilapp/services/animal_service.dart';
import 'package:flutter/material.dart';

class CreateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateWidgetState();
  }
}

class _CreateWidgetState extends State<CreateWidget> {
  var _currentAnimal = AnimalService().GetAnimal();

  @override
  void didUpdateWidget(covariant CreateWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _currentAnimal = AnimalService().GetAnimal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mój pupil'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              CreateRowWidget(_currentAnimal == SelectedAnimal.Cat ? "Nakarm kota" : "Nakarm psa", Icons.food_bank, (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder:
                    (context) => const CreateActionScreen(ActionType.feedCat)));
              }),
              CreateRowWidget(_currentAnimal == SelectedAnimal.Cat ? "Wyczyść kuwetę" : "Idź na spacer", Icons.clean_hands, (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder:
                    (context) => const CreateActionScreen(ActionType.cleanLitterBox)));
              }),
              CreateRowWidget("Odwiedź weterynarza", Icons.medical_services, (){
                Navigator.of(context)
                    .push(MaterialPageRoute(builder:
                    (context) => const CreateActionScreen(ActionType.checkoutVet)));
              }),
            ],
          )
        ],
      ),
    );
  }

}