import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restaurant/pages/main_pages/start_page.dart';
import '../models/ordersList.dart';
import '../server/provider.dart';

class OrdersPage extends StatelessWidget {
  fetchOrders(context) async {
    await NotifierProvider.read<OrdersList>(context)?.showOrders();
  }

  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchOrders(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Orders();
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}

class Orders extends StatelessWidget {
  Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<OrdersList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Список заказов'),
      ),
      body: Center(
        child: ListView.builder(
          itemExtent: 80,
          itemCount: model?.orders.length,
          itemBuilder: (BuildContext context, int index) {
            final order = model?.orders[index];
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Номер заказа ${order?.num},'),
                          const SizedBox(
                            width: 10,
                          ),
                          Text('стоимость  ${order?.count},'),
                          const SizedBox(
                            width: 10,
                          ),
                          (order?.is_closed == false)
                              ? const Text('статус: открыт')
                              : const Text('статус: закрыт')
                        ],
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return StartPage(orderNumber: order?.num,);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
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
