import 'package:flutter/material.dart';
import 'package:push_notification/services/dao_factory.dart';
import 'package:push_notification/widget/messaging_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DaoFactory.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Push Notification'),
          ),
          body: MessagingWidget(),
        )
    );
  }
}
