import 'package:floor/floor.dart';
import 'package:floordatabaseproject/data/entity/person_entity.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM PersonEntity')
  Future<List<PersonEntity>> findAllPeople();

  @Query('SELECT name FROM PersonEntity')
  Future<List<String>> findAllPeopleName();

  @Query('SELECT * FROM PersonEntity WHERE objectId = :objectId')
  Future<List<PersonEntity?>> findPersonById(String objectId);

  @insert
  Future<void> insertPerson(PersonEntity person);
}