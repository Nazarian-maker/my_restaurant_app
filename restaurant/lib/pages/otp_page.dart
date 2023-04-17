import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinPage extends StatefulWidget {
  const PinPage({Key? key}) : super(key: key);

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  TextEditingController textEditingController = TextEditingController();
  String pinText = '1234';
  String enterText = '';
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран авторизации'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.deepPurple,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (errorText != null) ...[
                Text(
                  errorText!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.amber,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
              const Text(
                'Введите пинкод',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              PinCodeTextField(
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                keyboardType: TextInputType.number,
                autoFocus: false,
                controller: textEditingController,
                appContext: context,
                length: 4,
                onChanged: (text) {
                  setState(() {
                    enterText = text;
                  });
                },
                onCompleted: (text) {
                  if (text == pinText) {
                    errorText = null;
                    FocusScope.of(context).unfocus();
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    });
                  } else {
                    errorText = 'Неверный пинкод!';
                  }
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
