import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  UserProductItem(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      // ignore: sized_box_for_whitespace
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
