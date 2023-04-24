import 'package:flutter/material.dart';

import '../../models/category_list.dart';
import '../../widgets/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

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
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showMyDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.height - 85,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                ListTile(
                  title: const Text(
                    'Категории нашего ресторана',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow[600], // Фоновый цвет
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
                Container(
                  padding: const EdgeInsets.all(5.0),
                  height: 270,
                  child: NotifierProvider(
                    model: model,
                    child: const _CategoriesWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoriesWidget extends StatelessWidget {
  const _CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<CategoryList>(context);
    if (model == null) return const SizedBox.shrink();
    return ListView.builder(
      itemCount: model.categories.length,
      padding: const EdgeInsets.all(30.0),
      itemBuilder: (BuildContext context, int index) {
        final category = model.categories[index];
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                category.url.toString(),
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(category.name.toString()),
            ]);
      },
    );
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