import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/models/cart.dart';
import 'package:restaurant/models/product.dart';
import 'package:restaurant/pages/main_pages/menu_page.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/pages/otp_page.dart';
import 'package:restaurant/pages/person_acc.dart';
import 'package:restaurant/pages/main_pages/splash_screen.dart';
import 'package:restaurant/pages/admin_auth_page.dart';
import 'package:restaurant/pages/main_pages/auth_page.dart';
import 'package:restaurant/pages/main_pages/start_page.dart';
import 'package:restaurant/server/provider.dart';

import 'models/auth_login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductDataProvider>(
          create: (context) => ProductDataProvider(),
        ),
        ChangeNotifierProvider<CartDataProvider>(
          create: (context) => CartDataProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Сытно и точка!',
        theme: ThemeData(
          textTheme: GoogleFonts.marmeladTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(background: Colors.white),
        ),
        routes: {
          '/': (context) => const SplashScreen(),
          '/auth/admin': (context) => NotifierProvider(
                model: AuthLogin(),
                child: const AdminAuth(),
              ),
          '/category_page': (context) => const StartPage(),
          '/category_page/category_menu': (context) {
            final arguments = ModalRoute.of(context)?.settings.arguments as int;
            if(arguments is int) {
              return Menu(categoryId: arguments);
            } else {
              return const Menu(categoryId: 0);
            }
          },
          '/auth/pin_page': (context) =>
              NotifierProvider(model: AuthLogin(), child: const PinPage()),
          '/person_acc': (context) =>
              NotifierProvider(model: AuthLogin(), child: const PersonAccount()),
          '/auth': (context) => const AuthWidget(),
        },
        initialRoute: '/',
      ),
    );
  }
}
