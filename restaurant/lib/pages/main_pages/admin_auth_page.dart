import 'package:flutter/material.dart';
import 'package:restaurant/models/auth_login.dart';
import 'package:restaurant/server/provider.dart';
import '../pass_reset/password_forgot.dart';

class AdminAuth extends StatelessWidget {
  const AdminAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthLogin>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран авторизации'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _ErrorMessageWidget(),
            const Text('Введите email:'),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: model?.loginTextController,
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
            const Text('Введите пароль:'),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: model?.passwordTextController,
              obscureText: true,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.of(context).pushNamed('/pin_page');
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.yellow.shade600),
                  ),
                  child: const Text(
                    'Войти по пинкоду',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _AuthButtonWidget(),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MyPasswordDialog(model: model);
                      },
                    );
                  },
                  child: const Text('Сбросить пароль'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Кнопка для входа в приложение
class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthLogin>(context);
    final onPressed =
        model?.canAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
        ? const SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Text('Войти');

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.yellow.shade600)),
      child: child,
    );
  }
}

//Вывод ошибок при входе
class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = NotifierProvider.watch<AuthLogin>(context)?.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.red,
        ),
      ),
    );
  }
}
