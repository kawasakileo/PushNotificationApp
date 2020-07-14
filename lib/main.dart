import 'package:flutter/material.dart';
import 'package:push_notification/widget/MessagingWidget.dart';

void main() => runApp(MyApp());

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
