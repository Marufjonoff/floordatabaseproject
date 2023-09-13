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
  String objectName = "";
  String objectId = "";

  List<PersonEntity?> persons = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    $FloorAppDatabase.databaseBuilder("app_database.db").build().then((value) async {
        objectId = widget.objectId;
        objectName = widget.objectName;

        final list = await _getPerson(objectId, value);
        persons = list;
        setState(() {});
    });
  }

  Future<List<PersonEntity?>> _getPerson(String objectId, AppDatabase database) async {
    return await database.personDao.findPersonById(objectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(objectName),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(persons[index]?.title ?? "", style: const TextStyle(fontWeight: FontWeight.w700)),
                        Text(persons[index]?.body ?? "", style: const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 15),
                        Text("CreatedAt: ${persons[index]?.createdAt.substring(0, 16) ?? ""}"),
                        Text("UpdatedAt: ${persons[index]?.updatedAt.substring(0, 16) ?? ""}"),
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
