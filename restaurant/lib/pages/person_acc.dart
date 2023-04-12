import 'package:flutter/material.dart';

class PersonAccount extends StatelessWidget {
  const PersonAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuRowData> menuRow = [
      MenuRowData(Icons.account_box, 'Настройки пользователей'),
      MenuRowData(Icons.account_box, 'Настройки пользователей'),
      MenuRowData(Icons.account_box, 'Настройки пользователей'),
      MenuRowData(Icons.account_box, 'Настройки пользователей'),
      MenuRowData(Icons.account_box, 'Настройки пользователей'),
      MenuRowData(Icons.account_box, 'Настройки пользователей'),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Личный кабинет'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false);
              },
              icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: CircleAvatar(
                  radius: 53,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.lightGreen,
                    child: Text(
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
            children: [
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
          SizedBox(
            height: 30,
          ),
          _MenuWidget(menuRow: menuRow),
        ],
      ),
    );
  }
}

class MenuRowData {
  final IconData icon;
  final String text;
  MenuRowData(
    this.icon,
    this.text,
  );
}

class _MenuWidget extends StatelessWidget {
  final List<MenuRowData> menuRow;

  const _MenuWidget({Key? key, required this.menuRow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: menuRow.map((data) => _MenuWidgetRow(data: data)).toList(),
      ),
    );
  }
}

class _MenuWidgetRow extends StatelessWidget {
  final MenuRowData data;

  const _MenuWidgetRow({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(data.icon),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(data.text),
          ),
          Icon(Icons.chevron_right_sharp),
        ],
      ),
    );
  }
}
