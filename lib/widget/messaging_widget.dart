import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification/message/message.dart';
import 'package:push_notification/services/devices/device.dart';
import 'package:push_notification/services/devices/device_dao.dart';
import '../services/user/user_dao.dart';
import '../services/user/user.dart';
import '../services/dao_factory.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  static String deviceToken;

  UserDao _userDao = DaoFactory.instance.userDao;
  DeviceDao _deviceDao = DaoFactory.instance.deviceDao;

  final user = User(1, '1234567890', 'name', 'username',
      'username@farmbits.com.br', '01234567980', true, deviceToken);
  final device = Device(1, 1, deviceToken);

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.getToken().then((token) {
      print("TOKEN: " + token);
      deviceToken = token;
      _userDao.save(user);
      _deviceDao.save(device);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print ("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
            title: notification['title'],
            body: notification['body']
          ));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print ("onLaunch: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'],
              body: notification['body']
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print ("onResume: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'],
              body: notification['body']
          ));
        });
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true)
    );
  }

  @override
  Widget build(BuildContext context) => ListView(
    children: messages.map(buildMessage).toList(),
  );

  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}
