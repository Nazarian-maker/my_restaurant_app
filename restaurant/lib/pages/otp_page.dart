import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:restaurant/server/provider.dart';

import '../models/auth_login.dart';

class PinPage extends StatelessWidget {
  const PinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthLogin>(context);

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
              const _ErrorMessageWidget(),
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
                controller: model?.pinTextController,
                appContext: context,
                length: 4,
                onChanged: (text) {
                  model?.pinText = text;
                },
                // onCompleted: (text) {
                //       () => model?.auth(context);
                //   // FocusScope.of(context).unfocus();
                //   //   Future.delayed(const Duration(seconds: 1), () {
                //   //     Navigator.pushNamedAndRemoveUntil(
                //   //         context, '/home', (route) => false);
                //   //   });
                // },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () => model?.authPin(context),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.yellow.shade600)),
                child: Text('Войти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage =
        NotifierProvider.watch<AuthLogin>(context)?.errorMessage;
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

// class PinPage extends StatefulWidget {
//   const PinPage({Key? key}) : super(key: key);
//
//   @override
//   State<PinPage> createState() => _PinPageState();
// }
//
// class _PinPageState extends State<PinPage> {
//   TextEditingController textEditingController = TextEditingController();
//   String pinText = '1234';
//   String enterText = '';
//   String? errorText;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Экран авторизации'),
//         backgroundColor: Colors.yellow,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.blue.shade800,
//               Colors.deepPurple,
//             ],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               if (errorText != null) ...[
//                 Text(
//                   errorText!,
//                   style: const TextStyle(
//                     fontSize: 18.0,
//                     color: Colors.amber,
//                   ),
//                 ),
//
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//               const Text(
//                 'Введите пинкод',
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               PinCodeTextField(
//                 textStyle: const TextStyle(
//                   color: Colors.white,
//                 ),
//                 keyboardType: TextInputType.number,
//                 autoFocus: false,
//                 controller: textEditingController,
//                 appContext: context,
//                 length: 4,
//                 onChanged: (text) {
//                   setState(() {
//                     enterText = text;
//                   });
//                 },
//                 onCompleted: (text) {
//                   if (text == pinText) {
//                     errorText = null;
//                     FocusScope.of(context).unfocus();
//                     Future.delayed(const Duration(seconds: 1), () {
//                       Navigator.pushNamedAndRemoveUntil(
//                           context, '/home', (route) => false);
//                     });
//                   } else {
//                     errorText = 'Неверный пинкод!';
//                   }
//                   setState(() {});
//                 },
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
