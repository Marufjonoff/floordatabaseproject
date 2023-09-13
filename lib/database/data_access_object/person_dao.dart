import 'package:floor/floor.dart';
import 'package:floordatabaseproject/data/entity/person_entity.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM PersonEntity WHERE objectId = :objectId')
  Future<List<PersonEntity?>> findPersonById(String objectId);

  @insert
  Future<void> insertPerson(PersonEntity person);

 // UPDATE PersonEntity
  // SET
  //    updatedAt = :updateAt,
  //    title = :title,
  //    body = :body
  // WHERE
  //     question_id = :question_id
  //     AND object_id = :object_id;

  @Query('SELECT * FROM PersonEntity')
  Future<List<PersonEntity>> findAllPeople();

  @update
  Future<void> updatePerson(PersonEntity entity);
}