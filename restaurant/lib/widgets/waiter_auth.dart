import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class WaiterAuth extends StatefulWidget {
  const WaiterAuth({Key? key}) : super(key: key);

  @override
  State<WaiterAuth> createState() => _WaiterAuthState();
}

class _WaiterAuthState extends State<WaiterAuth> {
  final _pinTextController = TextEditingController();
  String? errorText = null;

  void _auth() {
    final pin = _pinTextController.text;

    if (pin == 'waiter') {
      errorText = null;
      Navigator.of(context).pushNamed('/home');
    } else {
      errorText = 'Неверный пин!';
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

            Text('Введите пинкод:'),
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
