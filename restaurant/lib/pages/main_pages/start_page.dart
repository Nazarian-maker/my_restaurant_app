import 'package:flutter/material.dart';
import 'package:restaurant/models/auth_login.dart';
import '../../models/category/category_list.dart';
import '../../server/provider.dart';

class StartPage extends StatefulWidget {
  final orderNumber;

  const StartPage({Key? key, this.orderNumber}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final model = CategoryList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final func = NotifierProvider.read<AuthLogin>(context);
    final orderNum = widget.orderNumber;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showMyDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.yellow.shade600),
                child: const Center(
                  child: Text(
                    'Заказы',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.grey.shade600),
                child: ListTile(
                  title: const Text(
                    "Создать заказ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () => func?.createOrder(context),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/orders_page');
                },
                child: const Text(
                  'Перейти к списку заказов',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
              orderNum == null ? 'Категории ресторана' : 'Заказ $orderNum'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow[600],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/person_acc');
                    },
                    icon: const Icon(Icons.person, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: NotifierProvider(
            create: () => model,
            child: CategoriesWidget(orderNum: orderNum),
          ),
        ),
      ),
    );
  }
}

class CategoriesWidget extends StatelessWidget {
  final orderNum;
  const CategoriesWidget({Key? key, this.orderNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<CategoryList>(context);
    if (model == null) return const SizedBox.shrink();
    if (orderNum == null) {
      return const Text(
        'Создайте или выберите заказ',
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: model.categories.length,
        itemExtent: 200,
        itemBuilder: (BuildContext context, int index) {
          final category = model.categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Stack(
              children: [
                Center(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 130,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(category.url),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(category.name.toString()),
                      ],
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () =>
                        model.onCategoryTap(context, index, category.name),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
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
