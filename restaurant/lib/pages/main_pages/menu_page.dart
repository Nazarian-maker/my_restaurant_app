import 'package:flutter/material.dart';
import 'package:restaurant/models/product_list.dart';
import 'package:restaurant/server/provider.dart';
import 'package:restaurant/widgets/item_card.dart';
import '../../widgets/bottom_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Menu extends StatelessWidget {
  final categoryName;

  fetchDishes(context) async {
    await NotifierProvider.read<ProductList>(context)?.loadDishes();
  }

  const Menu({Key? key, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDishes(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Dishes(
              categoryName: categoryName,
            );
          } else {
            return const LoadingScreen();
          }
        });
  }
}

class Dishes extends StatelessWidget {
  final categoryName;
  const Dishes({Key? key, this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<ProductList>(context);

    if (model == null) return const SizedBox.shrink();
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
                title: Text(
                  '$categoryName',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                height: 290,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: model.product.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = model.product[index];
                    return ItemCard(
                      product: product,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
