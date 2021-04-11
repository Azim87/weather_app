// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorWeatherDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$WeatherDbBuilder databaseBuilder(String name) =>
      _$WeatherDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$WeatherDbBuilder inMemoryDatabaseBuilder() =>
      _$WeatherDbBuilder(null);
}

class _$WeatherDbBuilder {
  _$WeatherDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$WeatherDbBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$WeatherDbBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<WeatherDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$WeatherDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$WeatherDb extends WeatherDb {
  _$WeatherDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WeatherDao? _daoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 3,
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
            'CREATE TABLE IF NOT EXISTS `WeatherForecastResponse` (`id` INTEGER NOT NULL, `message` INTEGER NOT NULL, `cnt` INTEGER NOT NULL, `cod` TEXT NOT NULL, `list` TEXT NOT NULL, `city` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WeatherDao get dao {
    return _daoInstance ??= _$WeatherDao(database, changeListener);
  }
}

class _$WeatherDao extends WeatherDao {
  _$WeatherDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _weatherForecastResponseInsertionAdapter = InsertionAdapter(
            database,
            'WeatherForecastResponse',
            (WeatherForecastResponse item) => <String, Object?>{
                  'id': item.id,
                  'cnt': item.cnt,
                  'list': _weatherConverter.encode(item.list),
                  'city': _cityConverter.encode(item.city)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WeatherForecastResponse>
      _weatherForecastResponseInsertionAdapter;

  @override
  Future<WeatherForecastResponse?> getAllWeather() async {
    return _queryAdapter.query('SELECT * FROM WeatherForecastResponse',
        mapper: (Map<String, Object?> row) => WeatherForecastResponse(
            id: row['id'] as int,
            cnt: row['cnt'] as int,
            list: _weatherConverter.decode(row['list'] as String),
            city: _cityConverter.decode(row['city'] as String)));
  }

  @override
  Future<void> insertAllWeather(WeatherForecastResponse weather) async {
    await _weatherForecastResponseInsertionAdapter.insert(
        weather, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _weatherConverter = WeatherConverter();
final _cityConverter = CityConverter();
