import 'package:alewilapp/api/notification_api.dart';
import 'package:alewilapp/domain/action-type.dart';
import 'package:alewilapp/screens/main-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/animal_service.dart';

class CreateActionScreen extends StatefulWidget {
  final ActionType selectedAction;
  const CreateActionScreen(this.selectedAction, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateActionScreenState();
  }
}

class _CreateActionScreenState extends State<CreateActionScreen> {
  var _currentAnimal = AnimalService().GetAnimal();

  @override
  void didUpdateWidget(covariant CreateActionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    _currentAnimal = AnimalService().GetAnimal();
  }

  var titleMap = {
    ActionType.feedCat:"Nakarm kota",
    ActionType.checkoutVet:"Odwiedź weterynarza",
    ActionType.cleanLitterBox:"Wyczyść kuwetę"
  };

  var tileDogMap = {
    ActionType.feedCat:"Nakarm psa",
    ActionType.checkoutVet:"Odwiedź weterynarza",
    ActionType.cleanLitterBox:"Idź na spacer"
  };

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mój pupil'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
            alignment: Alignment.center,
            child: Text((_currentAnimal == SelectedAnimal.Cat ? titleMap[widget.selectedAction] : tileDogMap[widget.selectedAction]) ?? "not_title"),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            color: Theme.of(context).backgroundColor,
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => _selectDate(context),
              child: Text('wybierz datę'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            color: Theme.of(context).backgroundColor,
            alignment: Alignment.center,
            child: TextButton(

              onPressed: () => _selectTime(context),
              child: Text('wybierz czas'),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text("Powiadomienie pojawi się: "),
                Text(selectedDate.year.toString() + "-" + selectedDate.month.toString() + "-" + selectedDate.day.toString()),
                Text(selectedTime.hour.toString() + ":" + selectedTime.minute.toString())
              ],
            )
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
            color: Theme.of(context).backgroundColor,
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => {
                print(selectedDate),
                print(DateTime.now().add(Duration(seconds: DateTime.now().difference(selectedDate).inSeconds))),
                NotificationApi.showScheduledNotification(
                    scheduledDate: DateTime.now().add(Duration(seconds: DateTime.now().difference(selectedDate).inSeconds)),
                    body: (_currentAnimal == SelectedAnimal.Cat ? titleMap[widget.selectedAction] : tileDogMap[widget.selectedAction]) ?? "not_title",title: "Mój Pupil",),
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreenWidget())),

              },
              child: Text('stwórz'),
            ),
          ),
        ],
      ),
    );
  }

}