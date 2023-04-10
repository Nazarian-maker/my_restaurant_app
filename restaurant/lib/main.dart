import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/models/cart.dart';
import 'package:restaurant/models/product.dart';
import 'package:restaurant/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/pages/splash_screen.dart';
import 'package:restaurant/widgets/admin_auth.dart';
import 'package:restaurant/widgets/waiter_auth.dart';

void main() => runApp(MyApp());

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
        title: 'Сытно и точка!',
        theme: ThemeData(
          textTheme: GoogleFonts.marmeladTextTheme(
            Theme.of(context).textTheme,
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
              .copyWith(background: Colors.white),
        ),
        routes: {
          '/': (context) => SplashScreen(),
          '/waiter_auth': (context) => WaiterAuth(),
          '/admin_auth': (context) => AdminAuth(),
          '/home': (context) => HomePage(),
        },
        initialRoute: '/',
        // home: AuthWidget(),
        // HomePage(),
      ),
    );
  }
}
