// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao _userDaoInstance;

  DeviceDao _deviceDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `document` TEXT, `name` TEXT, `username` TEXT, `email` TEXT, `recoveryPhone` TEXT, `passwordUpdateRequired` INTEGER, `deviceToken` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `device` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `deviceToken` TEXT, FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  DeviceDao get deviceDao {
    return _deviceDaoInstance ??= _$DeviceDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (User item) => <String, dynamic>{
                  'id': item.id,
                  'document': item.document,
                  'name': item.name,
                  'username': item.username,
                  'email': item.email,
                  'recoveryPhone': item.recoveryPhone,
                  'passwordUpdateRequired': item.passwordUpdateRequired == null
                      ? null
                      : (item.passwordUpdateRequired ? 1 : 0),
                  'deviceToken': item.deviceToken
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _userMapper = (Map<String, dynamic> row) => User(
      row['id'] as int,
      row['document'] as String,
      row['name'] as String,
      row['username'] as String,
      row['email'] as String,
      row['recoveryPhone'] as String,
      row['passwordUpdateRequired'] == null
          ? null
          : (row['passwordUpdateRequired'] as int) != 0,
      row['deviceToken'] as String);

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<User> findOne(int id) async {
    return _queryAdapter.query('select * from User where id = ?',
        arguments: <dynamic>[id], mapper: _userMapper);
  }

  @override
  Future<User> findByDeviceToken(String deviceToken) async {
    return _queryAdapter.query('select * from User where deviceToken = ?',
        arguments: <dynamic>[deviceToken], mapper: _userMapper);
  }

  @override
  Future<void> save(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }
}

class _$DeviceDao extends DeviceDao {
  _$DeviceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _deviceInsertionAdapter = InsertionAdapter(
            database,
            'device',
            (Device item) => <String, dynamic>{
                  'id': item.id,
                  'userId': item.userId,
                  'deviceToken': item.deviceToken
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _deviceMapper = (Map<String, dynamic> row) => Device(
      row['id'] as int, row['userId'] as int, row['deviceToken'] as String);

  final InsertionAdapter<Device> _deviceInsertionAdapter;

  @override
  Future<Device> findOne(int id) async {
    return _queryAdapter.query('select * from Device where id = ?',
        arguments: <dynamic>[id], mapper: _deviceMapper);
  }

  @override
  Future<Device> findByDeviceToken(String deviceToken) async {
    return _queryAdapter.query('select * from Device where deviceToken = ?',
        arguments: <dynamic>[deviceToken], mapper: _deviceMapper);
  }

  @override
  Future<void> save(Device device) async {
    await _deviceInsertionAdapter.insert(device, OnConflictStrategy.abort);
  }
}
