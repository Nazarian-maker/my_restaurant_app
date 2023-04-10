import 'package:flutter/material.dart';

class ItemCatalog extends StatelessWidget {
  final String imgUrl;

  const ItemCatalog({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог меню'),
      ),
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 1,
          children: [
            _buildItem(imgUrl),
            _buildItem('https://darpizza.com/image/cache/catalog/free-412x391.png'),
            _buildItem('https://blackstarburger74.winmon.ru/upload/61b74906-de95-e486-3630-5e6685a502b2_image_c'),
            _buildItem('https://mcdonaldsmenu.ru/image/cache/catalog/photo/787268637-sous-syrnyj-600x600.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String imgUrl) => Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0),
          ],
          color: Colors.white,
        ),
      );
}

