import 'package:floor/floor.dart';
import 'package:push_notification/services/user/user.dart';

@Entity(tableName: "device",
  foreignKeys: [
    ForeignKey(
      childColumns: ['userId'],
      parentColumns: ['id'],
      entity: User,
    )
  ],
)
class Device {
  @PrimaryKey(autoGenerate: true)
  int id;
  int userId;
  String deviceToken;

  Device(this.id, this.userId, this.deviceToken);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Device && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => this.id ?? ''.hashCode;
}
