import 'package:caferesto/common/widgets/appbar/appbar.dart';
import 'package:caferesto/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'widgets/order_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: TAppBar(title: Text('Mes commandes', style: Theme.of(context).textTheme.headlineSmall,), showBackArrow: true,),
      body: const Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
      /// Orders
      child : TOrderListItems(),
      ),
    );
  }
}