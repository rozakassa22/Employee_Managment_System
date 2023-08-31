import 'package:flutter/material.dart';

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final IconData icon;
}

class SelectCard extends StatelessWidget {
  final Choice choice;
  const SelectCard({Key? key, required this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Icon(
                  choice.icon,
                  size: 50.0,
                  color: Colors.black,
                ),
              ),
              Text(
                choice.title,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ));
  }
}
