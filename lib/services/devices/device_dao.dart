import 'package:floor/floor.dart';
import 'device.dart';

@dao
abstract class DeviceDao {
  @insert
  Future<void> save(Device device);

  @Query('select * from Device where id = :id')
  Future<Device> findOne(int id);

  @Query('select * from Device where deviceToken = :deviceToken')
  Future<Device> findByDeviceToken(String deviceToken);
}
