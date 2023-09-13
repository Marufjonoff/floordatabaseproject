import 'package:floordatabaseproject/data/entity/person_entity.dart';
import 'package:floordatabaseproject/database/database.dart';
import 'package:floordatabaseproject/service/log_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddScreen extends StatefulWidget {
  final String objectId;
  final String objectName;

  const AddScreen({Key? key, required this.objectId, required this.objectName}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late AppDatabase database;
  String objectId = "";
  String objectName = "";

  bool loading = false;

  TextEditingController titleController = TextEditingController(text: "title ");
  TextEditingController bodyController = TextEditingController(text: "body ");

  @override
  void initState() {
    super.initState();

    $FloorAppDatabase.databaseBuilder('app_database.db').build().then((value) async {
      database = value;
      objectId = widget.objectId;
      objectName = widget.objectName;
      setState(() {});
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
    titleController.text = "title ";
    bodyController.text = "body ";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Add to $objectName")),
      body: loading ?
      const Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title"
              ),
            ),

            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                  hintText: "Body"
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPerson(database, objectId);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white, size: 26),
      ),
        );
  }
}
