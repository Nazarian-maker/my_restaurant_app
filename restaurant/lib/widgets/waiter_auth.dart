import 'package:flutter/material.dart';

class WaiterAuth extends StatefulWidget {
  const WaiterAuth({Key? key}) : super(key: key);

  @override
  State<WaiterAuth> createState() => _WaiterAuthState();
}

class _WaiterAuthState extends State<WaiterAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Экран авторизации'),
      ),
    );
  }
}
