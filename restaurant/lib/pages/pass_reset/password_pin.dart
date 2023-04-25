import 'package:flutter/material.dart';

import 'new_user_password.dart';

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
            if (model?.mailPinTextController?.text?.isEmpty ?? true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Введите пинкод!",
                    style: TextStyle(color: Colors.red),
                  ),
                  backgroundColor: Colors.white,
                ),
              );
            } else {
              model?.passwordPin(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NewUserPassword(
                    model: model,
                  );
                },
              );
            }
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
