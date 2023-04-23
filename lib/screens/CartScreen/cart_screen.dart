import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/providers/cart_provider.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    getCart();
  }

  void getCart() {
    CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.getCart();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    print(cartProvider.cartDataModel?.products.length.toString());
    return Scaffold(
      appBar: buildAppBar(title: 'Sepetim', showBackButton: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
