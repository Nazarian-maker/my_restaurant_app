import 'package:flutter/material.dart';
import 'package:restaurant/models/cart.dart';
import 'package:restaurant/pages/item_page.dart';
import '../server/provider.dart';

class ItemCard extends StatelessWidget {
  final product;
  const ItemCard({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.yellow.shade600,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              //  Переход на страницу товара
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ItemPage(productId: product.id, product: product),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(product.url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('${product.cost}'),
              IconButton(
                onPressed: () {
                  NotifierProvider.watch<CartDataProvider>(context)?.addItem(
                    productId: product.id,
                    price: product.cost,
                    title: product.name,
                    imgUrl: product.url,
                  );
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
