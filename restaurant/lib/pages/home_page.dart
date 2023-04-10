import 'package:restaurant/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/widgets/item_card.dart';

import '../widgets/bottom_bar.dart';
import '../widgets/catalog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductDataProvider>(context);

    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height - 85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              // bottomRight: Radius.circular(35),
              // bottomLeft: Radius.circular(35),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              Container(
                child: ListTile(
                  title: Text('Меню нашего ресторана',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  trailing: Icon(Icons.restaurant),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                height: 270,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productData.items.length,
                  itemBuilder: (context, int index) =>
                      ChangeNotifierProvider.value(
                    value: productData.items[index],
                    child: ItemCard(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Каталог меню'),
              ),
              ...productData.items.map((value) {
                return CatalogListTile(
                    imgUrl: value.imgUrl,
                    title: value.title,
                    price: value.price,
                );
              }).toList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
