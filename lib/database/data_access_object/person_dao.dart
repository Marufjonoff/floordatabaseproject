import 'package:floor/floor.dart';
import 'package:floordatabaseproject/data/entity/person_entity.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM PersonEntity')
  Future<List<PersonEntity>> findAllPeople();

  @Query('SELECT name FROM PersonEntity')
  Future<List<String>> findAllPeopleName();

  @Query('SELECT * FROM PersonEntity WHERE id = :id')
  Future<PersonEntity?> findPersonById(String id);

  @insert
  Future<void> insertPerson(PersonEntity person);
}