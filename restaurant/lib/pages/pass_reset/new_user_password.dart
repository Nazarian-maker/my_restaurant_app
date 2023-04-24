import 'package:flutter/material.dart';

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
            Navigator.pushNamedAndRemoveUntil(
                context, '/admin_auth', (route) => false);
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
            if (model?.newPasswordController.text.isEmpty ||
                model?.newPasswordConfirmationController.text.isEmpty) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Ошибка!'),
                    content: const Text(
                        'Для ввода нового пароля необходимо заполнить все поля.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            } else {
              model?.newUserPasswordSet(context);
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text('Пароль был успешно изменён!'),
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/admin_auth', (route) => false);
              });
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
