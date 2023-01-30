import 'package:alewilapp/screens/choose-animal.dart';
import 'package:alewilapp/services/animal_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void AnimalCallback(SelectedAnimal animal);

class ChooseAnimalActionWidget extends StatefulWidget {
  final String text;
  final IconData icon;
  final SelectedAnimal animal;
  final AnimalCallback actionCallback;
  final Color color;

  ChooseAnimalActionWidget(this.text, this.icon, this.animal,
      this.actionCallback, this.color, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChooseAnimalActionWidgetState();
  }
}

const double defaultWidth = 120;

class _ChooseAnimalActionWidgetState extends State<ChooseAnimalActionWidget> {
  double width = defaultWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Material(
            color: widget.color,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: AnimatedContainer(
              width: width,
              height: MediaQuery.of(context).size.height * 0.8,
              curve: Curves.bounceInOut,
              duration: const Duration(milliseconds: 300),
              child: InkWell(
                onTap: () {
                  setState(() {
                    width <= defaultWidth
                        ? width = defaultWidth + 150
                        : width = defaultWidth;
                  });

                  if (width > defaultWidth) {
                    widget.actionCallback(widget.animal);

                    return;
                  }

                  widget.actionCallback(SelectedAnimal.Default);
                },
                child: Center(
                  child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(widget.icon, size: 40, color: Colors.white,),
                          Text(widget.text, style: const TextStyle(fontSize: 32, color: Colors.white),)
                        ],
                      ),
                )
              ),
            )));
  }
}
