import 'package:flutter/material.dart';

class AdminAuth extends StatefulWidget {
  const AdminAuth({Key? key}) : super(key: key);

  @override
  State<AdminAuth> createState() => _AdminAuthState();
}

class _AdminAuthState extends State<AdminAuth> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _pinTextController = TextEditingController();
  String? errorText = null;

  void _auth() {
    final email = _loginTextController.text;
    final password = _passwordTextController.text;
    final pin = _pinTextController.text;

    if (email == 'admin@mail.ru' && password == 'admin' || pin == 'admin') {
      errorText = null;
    } else {
      errorText = 'Неверный пин, логин или пароль!';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final errorText = this.errorText;

    return Scaffold(
      appBar: AppBar(
        title: Text('Экран авторизации'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            if (errorText != null) ...[
              Text(
                errorText,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],

            Text('Введите email:'),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _loginTextController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Введите пароль:'),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordTextController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Или войдите через пинкод'),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _pinTextController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _auth,
                  child: Text('Войти'),
                ),
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