import 'package:floordatabaseproject/data/api_client.dart';
import 'package:floordatabaseproject/data/entity/person_entity.dart';
import 'package:floordatabaseproject/service/log_service.dart';

class PersonRepository {
  ApiClient? apiClient;

  PersonRepository({this.apiClient});

  /// handler sign
  Future<List<PersonEntity>?> _personResponse() async {
    List<PersonEntity>? personEntity;
    try {
      personEntity = await apiClient?.getPersonData();
    } catch(e) {
      LogService.instance.error("Xatolik");
    }
    return personEntity;
  }

  /// response
  Future<dynamic> personResponse() async {
    final response = await _personResponse();
    return response;
  }

}