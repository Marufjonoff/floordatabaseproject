// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

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
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
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
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PersonDao? _personDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `PersonEntity` (`createdAt` TEXT NOT NULL, `updatedAt` TEXT NOT NULL, `objectId` TEXT NOT NULL, `title` TEXT NOT NULL, `body` TEXT NOT NULL, `id` TEXT NOT NULL, PRIMARY KEY (`createdAt`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PersonDao get personDao {
    return _personDaoInstance ??= _$PersonDao(database, changeListener);
  }
}

class _$PersonDao extends PersonDao {
  _$PersonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _personEntityInsertionAdapter = InsertionAdapter(
            database,
            'PersonEntity',
            (PersonEntity item) => <String, Object?>{
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'objectId': item.objectId,
                  'title': item.title,
                  'body': item.body,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PersonEntity> _personEntityInsertionAdapter;

  @override
  Future<List<PersonEntity>> findAllPeople() async {
    return _queryAdapter.queryList('SELECT * FROM PersonEntity',
        mapper: (Map<String, Object?> row) => PersonEntity(
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            objectId: row['objectId'] as String,
            title: row['title'] as String,
            body: row['body'] as String,
            id: row['id'] as String));
  }

  @override
  Future<List<String>> findAllPeopleName() async {
    return _queryAdapter.queryList('SELECT name FROM PersonEntity',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<List<PersonEntity?>> findPersonById(String objectId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PersonEntity WHERE objectId = ?1',
        mapper: (Map<String, Object?> row) => PersonEntity(
            createdAt: row['createdAt'] as String,
            updatedAt: row['updatedAt'] as String,
            objectId: row['objectId'] as String,
            title: row['title'] as String,
            body: row['body'] as String,
            id: row['id'] as String),
        arguments: [objectId]);
  }

  @override
  Future<void> insertPerson(PersonEntity person) async {
    await _personEntityInsertionAdapter.insert(
        person, OnConflictStrategy.abort);
  }
}
