import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/models/cart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant/pages/cart_page.dart';

class ItemPage extends StatelessWidget {
  final String productId;

  const ItemPage({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   data.title,
        //   style: GoogleFonts.marmelad(),
        // ),
      ),
      body: ListView(
        children: [
          // Hero(
          //   // tag: data.imgUrl,
          //   child: Container(
          //     height: 300,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //       // image: DecorationImage(
          //         // image: NetworkImage(data.imgUrl),
          //         // fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          Card(
            elevation: 5.0,
            margin:
                const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  // Text(
                    // data.title,
                    // style: TextStyle(fontSize: 26.0),
                  // ),
                  Divider(),
                  Row(
                    children: [
                      const Text(
                        'Цена ',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      // Text(
                      //   '${data.price} ',
                      //   style: TextStyle(fontSize: 24.0),
                      // ),
                    ],
                  ),
                  const Divider(),
                  // Text(data.description),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Provider.of<CartDataProvider>(context)
                          .cartItems
                          .containsKey(productId)
                      ? Column(
                          children: [
                            MaterialButton(
                                color: const Color(0xFFFDD835),
                                child: const Text('Перейти в корзину '),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => CartPage(),
                                  ));
                                }),
                            const Text(
                              'Товар уже доюавлен в корзину!',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        )
                      : MaterialButton(
                          color: Colors.yellow.shade600,
                          onPressed: () {
                            Provider.of<CartDataProvider>(context,
                                    listen: false)
                                .addItem(
                              // productId: data.id,
                              // imgUrl: data.imgUrl,
                              // title: data.title,
                              // price: data.price,
                            );
                          },
                          child: const Text('Добавить в корзину'),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
