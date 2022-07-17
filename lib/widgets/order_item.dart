import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as oi;

class OrderItem extends StatelessWidget {
  final oi.OrderItem order;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
