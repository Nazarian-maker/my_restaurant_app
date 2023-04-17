import 'package:flutter/material.dart';
import 'package:restaurant/models/auth_login.dart';

class AdminAuth extends StatelessWidget {
  const AdminAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;

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
              children: const [
                _AuthButtonWidget(),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: null,
                  child: Text('Сбросить пароль'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
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

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;
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

// class AdminAuth extends StatefulWidget {
//   const AdminAuth({Key? key}) : super(key: key);
//
//   @override
//   State<AdminAuth> createState() => _AdminAuthState();
// }
//
// class _AdminAuthState extends State<AdminAuth> {
//   final _loginTextController = TextEditingController();
//   final _passwordTextController = TextEditingController();
//   String? errorText;
//
//   void _auth() {
//     final email = _loginTextController.text;
//     final password = _passwordTextController.text;
//
//     if (email == 'admin@mail.ru' && password == 'admin') {
//       errorText = null;
//       FocusScope.of(context).unfocus();
//       Future.delayed(const Duration(seconds: 1), () {
//         Navigator.of(context).pushNamed('/home');
//       });
//     } else {
//       errorText = 'Неверный логин или пароль!';
//     }
//
//     setState(() {});
//   }
