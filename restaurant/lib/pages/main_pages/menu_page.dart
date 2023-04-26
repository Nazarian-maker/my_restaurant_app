import 'package:flutter/material.dart';
import 'package:restaurant/models/product_list.dart';
import 'package:restaurant/server/provider.dart';
import 'package:restaurant/widgets/item_card.dart';
import '../../widgets/bottom_bar.dart';

class Menu extends StatefulWidget {
  final categoryName;
  const Menu({Key? key, this.categoryName}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

 @override
  void initState() {
    super.initState();
    NotifierProvider.read<ProductList>(context)?.loadDishes();
  }

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<ProductList>(context);
    if (model == null) return const SizedBox.shrink();
    final categoryName = widget.categoryName;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height - 85,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            padding: const EdgeInsets.all(10.0),
            children: <Widget>[
              ListTile(
                title: Text('Меню категории $categoryName',
                    style:
                        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                height: 270,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: model.product.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = model.product[index];
                    return ItemCard(product: product,);
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Остальные категории'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
