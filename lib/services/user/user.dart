import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class User {
  @PrimaryKey(autoGenerate: true)
  int id;
  String document;
  String name;
  String username;
  String email;
  String recoveryPhone;
  bool passwordUpdateRequired = true;
  String deviceToken;

  User(this.id, this.document, this.name, this.username, this.email,
      this.recoveryPhone, this.passwordUpdateRequired, this.deviceToken);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => this.id ?? ''.hashCode;
}
