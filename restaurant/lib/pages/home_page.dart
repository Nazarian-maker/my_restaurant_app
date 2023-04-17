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

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showMyDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height - 85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                // bottomRight: Radius.circular(35),
                // bottomLeft: Radius.circular(35),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: <Widget>[
                ListTile(
                  title: const Text('Меню нашего ресторана',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/person_acc');
                      },
                      icon: const Icon(Icons.person),
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
                      child: const ItemCard(),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
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
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }

  Future<bool?> showMyDialog(context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Вы хотите выйти?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Нет'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Да'),
          ),
        ],
      ),
  );
}
