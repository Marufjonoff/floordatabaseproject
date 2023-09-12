import 'package:floordatabaseproject/data/entity/person_entity.dart';
import 'package:floordatabaseproject/database/database.dart';
import 'package:floordatabaseproject/service/log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String id;
  const HomeScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeBloc();
  late AppDatabase database;
  String objectId = "";

  bool loading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((value) async {
      database = value;
      setState(() {});
      objectId = widget.id;

      final person = await _getPerson(objectId);
      LogService.instance.info(person.first?.title);

      // final person = await _getPerson();
      // LogService.instance.info(person?.createdAt);
      // await getAllPersons();
    });
  }

  Future<void> addPerson(AppDatabase databases, String objectId) async {
    loading = true;
    setState(() {});

    final personDao = databases.personDao;

    var uuid = const Uuid();
    final id = uuid.v1();

    LogService.instance.info(id);

    final personEntity = PersonEntity(
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        objectId: objectId,
        title: "${titleController.text.trim()} $objectId",
        body: bodyController.text.trim(),
        id: id
    );

    await personDao.insertPerson(personEntity);

    loading = false;
    titleController.clear();
    bodyController.clear();
    setState(() {});
  }

  Future<List<PersonEntity?>> _getPerson(String objectId) async {
    return await database.personDao.findPersonById(objectId);
  }

  // Future<void> getAllPersons() async {
  //   PersonRepository repository = PersonRepository(apiClient: ApiClient.getAuthInstance());
  //   final personDao = database.personDao;
  //   final response = await repository.personResponse();
  //   LogService.instance.info(DateTime.now().toString());
  //   if(response is List<PersonEntity>) {
  //     for(int i = 2; i < response.length; i++) {
  //       // await personDao.insertPerson(response[i]);
  //     }
  //   }
  //   LogService.instance.info(DateTime.now().toString());
  // }

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
             body: loading ?
             const Center(child: CircularProgressIndicator()) : Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
                   TextField(
                     controller: titleController,
                   ),

                   TextField(
                     controller: bodyController,
                   ),
                 ],
               ),
             ),
             floatingActionButton: FloatingActionButton(
               onPressed: (){
                 addPerson(database, objectId);
               },
               backgroundColor: Colors.blue,
               child: const Icon(Icons.add, color: Colors.white, size: 26),
             ),
          );
        },
      ),
    );
  }
}
