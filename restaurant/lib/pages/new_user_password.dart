import 'package:flutter/material.dart';
import 'package:restaurant/models/auth_login.dart';

//Окно для ввода нового пароля
class NewUserPassword extends StatelessWidget {
  final model;
  const NewUserPassword({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Введите новый пароль:'),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            TextField(
              controller: model?.newPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Введите новый пароль повторно:'),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: model?.newPasswordConfirmationController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/admin_auth', (route) => false);
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
            model?.newUserPasswordSet(context);
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const SuccessWindow();
              },
            );
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

class SuccessWindow extends StatelessWidget {
  const SuccessWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Пароль был успешно изменён!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/admin_auth', (route) => false);
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
