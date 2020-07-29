import 'dart:async';

import 'package:push_notification/services/devices/device.dart';
import 'package:push_notification/services/devices/device_dao.dart';

import 'devices/device_dao.dart';
import 'user/user.dart';
import 'user/user_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

/// DO NOT delete these from here: ---------------------------------------------
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
/// ------------------------------------------------------------ as far as here.

part 'database.g.dart'; // the generated code will be there

const int DATABASE_TEST = 1;

@Database(version: DATABASE_TEST, entities: [
  User,
  Device
])

abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  DeviceDao get deviceDao;
}
