import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  // ignore: use_key_in_widget_constructors
  const ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {},
        ),
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
