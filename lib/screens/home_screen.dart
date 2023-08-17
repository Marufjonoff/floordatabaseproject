import 'package:floor/floor.dart';
import 'package:floordatabaseproject/data/api_client.dart';
import 'package:floordatabaseproject/data/entity/person_entity.dart';
import 'package:floordatabaseproject/data/repository/person_repository.dart';
import 'package:floordatabaseproject/database/database.dart';
import 'package:floordatabaseproject/service/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc();
  late AppDatabase database;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build()
        .then((value) async {
      database = value;
      setState(() {});
      final person = await _getPerson();
      LogService.instance.info(person?.createdAt);
      await getAllPersons();
    });
  }

  Future<void> addPerson(AppDatabase database) async {
    final personDao = database.personDao;

    final personEntity = PersonEntity(createdAt: "createdAt 1", updatedAt: "updatedAt 1", avatar: "avatar 1", title: "title 1", body: "body 1", id: "2");

    await personDao.insertPerson(personEntity);
  }

  Future<PersonEntity?> _getPerson() async {
    return await database.personDao.findPersonById("100");
  }

  Future<void> getAllPersons() async {
    PersonRepository repository = PersonRepository(apiClient: ApiClient.getAuthInstance());
    final personDao = database.personDao;
    final response = await repository.personResponse();
    LogService.instance.info(DateTime.now().toString());
    if(response is List<PersonEntity>) {
      for(int i = 2; i < response.length; i++) {
        // await personDao.insertPerson(response[i]);
      }
    }
    LogService.instance.info(DateTime.now().toString());
  }


  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
           return Scaffold(
            appBar: AppBar(title: const Text("Home")),
          );
        },
      ),
    );
  }
}
