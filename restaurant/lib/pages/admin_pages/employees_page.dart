import 'package:flutter/material.dart';
import 'package:restaurant/models/users/users_list.dart';

import '../../models/users/users.dart';

class EmployeesPage extends StatefulWidget {
  EmployeesPage({Key? key}) : super(key: key);

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final model = UsersList();
  late Future<List<Users>> _futureData; // новая переменная Future

  @override
  void initState() {
    super.initState();

    _futureData = _refreshData(); // инициализируем Future в initState
  }

  Future<List<Users>> _refreshData() async {
    await model.loadUsers();

    return model.users; // возвращаем данные из модели
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Назад'),
      ),
      body: FutureBuilder(
        future: _futureData, // используем Future вместо переменной UsersList
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error!'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length, // обращаемся к данным из Future
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        '${user.name}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    subtitle: Text('${user.email}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit, color: Colors.indigo),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Создать нового сотрудника',
        child: const Icon(Icons.add),
      ),
    );
  }
}
