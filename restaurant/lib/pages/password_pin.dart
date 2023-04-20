import 'package:flutter/material.dart';

//Окно с вводом пинкода для сброса пароля
class PinPasswordForgot extends StatelessWidget {
  final model;
  const PinPasswordForgot({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text('Введите пинкод, присланный на почту:'),
      content: TextField(
        keyboardType: TextInputType.number,
        controller: model?.mailPinTextController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            model?.userPassForgot(context);
          },
          child: const Text(
            'Отправить снова',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            model?.passwordPin(context);
          },
          child: const Text(
            'Дальше',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}