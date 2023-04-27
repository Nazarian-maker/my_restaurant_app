import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/models/cart.dart';
import '../widgets/cart_list_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartData = context.watch<CartDataProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: cartData.cartItems.isEmpty
          ? Card(
              elevation: 5.0,
              margin: const EdgeInsets.all(30.0),
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                child: const Text('Корзина пустая'),
              ),
            )
          : Column(
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Стоимость: ${cartData.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    MaterialButton(
                      onPressed: () {
                        cartData.clear();
                      },
                      color: Colors.yellow.shade600,
                      child: const Text('Рассчитать!'),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: CartItemList(cartData: cartData),
                ),
              ],
            ),
    );
  }
}
