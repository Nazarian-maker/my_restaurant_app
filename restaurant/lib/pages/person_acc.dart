import 'package:flutter/material.dart';
import '../models/auth_login.dart';
import '../server/provider.dart';
import 'admin_pages/categories_page.dart';
import 'admin_pages/dishes_page.dart';
import 'admin_pages/employees_page.dart';
import 'admin_pages/order_page.dart';
import 'admin_pages/reports_page.dart';

class PersonAccount extends StatelessWidget {
  const PersonAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthLogin>(context);
    final role = model?.getRole;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Личный кабинет'),
        actions: [
          IconButton(
            onPressed: () => model?.userExit(context),
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.yellow.shade600,
                    child: const Text(
                      'User',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'User Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${model?.getRole}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          if (role != 'waiter') _FunctionList(),
        ],
      ),
    );
  }
}

class _FunctionList extends StatelessWidget {
  _FunctionList({Key? key}) : super(key: key);

  List<String> items = ["Сотрудники", "Блюда", "Категории", "Заказы", "Отчеты"];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      width: double.infinity,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index]),
            trailing: const Icon(Icons.arrow_forward_ios_sharp),
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmployeesPage()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DishesPage()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoriesPage()),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderPage()),
                  );
                  break;
                case 4:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportsPage()),
                  );
                  break;
                default:
                  break;
              }
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: items.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}
