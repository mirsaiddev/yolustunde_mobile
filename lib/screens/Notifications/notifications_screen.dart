import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolustunde_mobile/providers/user_provider.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  void getNotifications() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Bildirimler'),
    );
  }
}
