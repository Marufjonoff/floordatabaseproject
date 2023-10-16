import 'package:floor/floor.dart';
import 'package:floordatabaseproject/data/entity/person_entity.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM PersonEntity WHERE objectId = :objectId')
  Future<List<PersonEntity?>> findPersonById(String objectId);

  @insert
  Future<void> insertPerson(PersonEntity person);

  @Query('SELECT * FROM PersonEntity')
  Future<List<PersonEntity>> findAllPeople();

  @update
  Future<void> updatePerson(PersonEntity entity);

  @Query('DELETE FROM PersonEntity WHERE objectId=:objectId')
  Future<void> deleteById(String objectId);
}