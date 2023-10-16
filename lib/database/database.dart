import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floordatabaseproject/data/entity/person_entity.dart';
import 'package:floordatabaseproject/database/data_access_object/person_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [PersonEntity])
abstract class AppDatabase extends FloorDatabase {
  PersonDao get personDao;
}