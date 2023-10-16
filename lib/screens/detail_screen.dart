import 'package:floordatabaseproject/data/entity/person_entity.dart';
import 'package:floordatabaseproject/database/database.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String objectId;
  final String objectName;

  const DetailScreen({super.key, required this.objectId, required this.objectName});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final AppDatabase database;
  String objectName = "";
  String objectId = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  List<PersonEntity?> persons = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    $FloorAppDatabase.databaseBuilder("app_database.db").build().then((value) async {
        objectId = widget.objectId;
        objectName = widget.objectName;
        database = value;

        final list = await _getPerson(objectId, value);
        persons = list;

        setState(() {});
    });
  }

  Future<List<PersonEntity?>> _getPerson(String objectId, AppDatabase databases) async {
    return await databases.personDao.findPersonById(objectId);
  }

  Future<void> _update(PersonEntity? entity) async {

    final newEntity = PersonEntity(
        createdAt: entity?.createdAt ?? "",
        updatedAt: DateTime.now().toString(),
        objectId: entity?.objectId ?? "",
        title: titleController.text,
        body: bodyController.text,
        id: entity?.id ?? ""
    );

    await database.personDao.updatePerson(newEntity);

    persons.clear();

    final list = await _getPerson(objectId, database);
    persons = list;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(objectName),
        actions: [
          IconButton(
            onPressed: () async {
              await database.personDao.deleteById(objectId);
              final list = await _getPerson(objectId, database);
              persons = list;

              setState(() {});
            },
            icon: const Icon(Icons.delete, color: Colors.red),
          )
        ],
      ),
      body: loading
      ? const Center(child: CircularProgressIndicator())
      : persons.isEmpty ? const Center(child: Text("Ma'lumotlar topilmadi"))
      : ListView.builder(
        itemCount: persons.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Card(
            child: Ink(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(7.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(persons[index]?.title ?? "", style: const TextStyle(fontWeight: FontWeight.w700)),
                            Text(persons[index]?.body ?? "", style: const TextStyle(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 15),
                            Text("CreatedAt: ${persons[index]?.createdAt.substring(0, 16) ?? ""}"),
                            Text("UpdatedAt: ${persons[index]?.updatedAt.substring(0, 16) ?? ""}"),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              titleController.text = persons[index]?.title ?? "";
                              bodyController.text = persons[index]?.body ?? "";
                            });
                            await showModalBottomSheet(
                              context: context,
                              elevation: 5,
                              backgroundColor: Colors.transparent.withOpacity(0.5),
                              builder: (context) {
                                return Container(
                                  height: MediaQuery.sizeOf(context).height / 2,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0)),
                                    color: Colors.white
                                  ),
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

                                      TextButton(
                                        onPressed: () async {
                                          _update(persons[index]);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Save", style: TextStyle(color: Colors.blue)),
                                      )
                                    ],
                                  ),
                                );
                              }
                            );

                            setState(() {});
                          },
                          icon: const Icon(Icons.edit, size: 26, color: Colors.green),
                          splashRadius: 30,
                        ),
                        const SizedBox(width: 10)
                      ],
                    )
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}
