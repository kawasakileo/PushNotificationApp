import 'package:floor/floor.dart';
import 'database.dart' as dao_factory;
import 'database.dart';

class DaoFactory {
  static AppDatabase instance;

  static Future<void> initForTests(AppDatabase appDatabase) async {
    instance = appDatabase;
  }

  static Future<void> init() async {
    instance = await dao_factory.$FloorAppDatabase
        .databaseBuilder('mock.db')
        .build();
  }
}
