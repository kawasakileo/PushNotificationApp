import 'package:floor/floor.dart';
import 'user.dart';

@dao
abstract class UserDao {
  @insert
  Future<void> save(User user);

  @Query('select * from User where id = :id')
  Future<User> findOne(int id);

  @Query('select * from User where deviceToken = :deviceToken')
  Future<User> findByDeviceToken(String deviceToken);
}
