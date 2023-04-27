import 'package:flutter/material.dart';
import 'package:restaurant/pages/cart_page.dart';

class ItemPage extends StatelessWidget {
  final int productId;
  final product;

  const ItemPage({Key? key, required this.productId, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Назад'),
      ),
      body: ListView(
        children: [
          Hero(
            tag: product.url,
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Card(
            elevation: 5.0,
            margin:
                const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 26.0),
                  ),
                  const Divider(),
                  Text(
                    product.composition,
                    style: const TextStyle(fontSize: 26.0),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Text(
                        'Цена ',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      Text(
                        '${product.cost} ',
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const Divider(),
                  // Text(data.description),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    children: [
                      MaterialButton(
                          color: const Color(0xFFFDD835),
                          child: const Text('Перейти в корзину '),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CartPage(),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
