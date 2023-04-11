import 'package:flutter/material.dart';
import 'package:restaurant/pages/catalog_page.dart';

class CatalogListTile extends StatelessWidget {
  final imgUrl;
  final title;
  final price;
  final String komboName = "комбо";
  CatalogListTile({Key? key, this.imgUrl, this.title, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  Navigation in catalog
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ItemCatalog(
            imgUrl: imgUrl,
          ),
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text('${title} ${komboName}'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Цена ${price * 2}'),
              // IconButton(
              //   // onPressed: () {
              //   //   Provider.of<CartDataProvider>(context, listen: false).addItem(
              //   //     productId: product.id,
              //   //     price: product.price,
              //   //     title: product.title,
              //   //     imgUrl: product.imgUrl,
              //   //   );
              //   // },
              //   icon: Icon(
              //     Icons.add_circle_outline,
              //     color: Colors.black54,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
