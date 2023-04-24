import 'package:flutter/material.dart';
import 'package:restaurant/pages/pass_reset/password_pin.dart';

//Метод для сброса пароля
class MyPasswordDialog extends StatelessWidget {
  final model;
  const MyPasswordDialog({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Введите вашу почту'),
      content: TextField(
        controller: model?.mailTextController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Отменить');
          },
          child: const Text(
            'Отменить',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            if (model?.mailTextController.text.isEmpty ?? true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Заполните поле ввода почты',
                    style: TextStyle(color: Colors.red),
                  ),
                  backgroundColor: Colors.white,
                ),
              );
            } else {
              model?.userPassForgot(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PinPasswordForgot(
                    model: model,
                  );
                },
              );
            }
          },
          child: const Text(
            'Отправить',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
