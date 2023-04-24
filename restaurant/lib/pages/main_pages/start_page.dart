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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              children: [
                ListTile(
                  title: const Text(
                    'Категории нашего ресторана',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
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
                Container(
                  height: 800,
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
    return Stack(
      children: [
        ListView.builder(
          itemCount: model.categories.length,
          itemExtent: 200,
          itemBuilder: (BuildContext context, int index) {
            final category = model.categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade600,
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
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network(
                          category.url.toString(),
                          width: 150,
                          height: 150,
                        ),
                        Text(category.name.toString()),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => model.onCategoryTap(context, index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
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
