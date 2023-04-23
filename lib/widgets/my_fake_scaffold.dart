import 'package:flutter/material.dart';

class MyFakeScaffold extends StatelessWidget {
  const MyFakeScaffold({
    Key? key,
    required this.image,
    this.child,
  }) : super(key: key);

  final String image;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 20),
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        child: child,
      ),
    );
  }
}
