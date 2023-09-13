import 'package:floordatabaseproject/screens/add_screen.dart';
import 'package:floordatabaseproject/screens/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

enum SampleItem { itemOne, itemTwo, itemThree }

class _MainScreenState extends State<MainScreen> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Objects"),
      ),
      body: ListView.builder(
        itemCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return Card(
            child: Ink(
              height: 60,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(context, CupertinoPageRoute(
                      builder: (_) => DetailScreen(objectId: "object${index+1}", objectName: "Object ${index+1}")
                    ));
                  },
                  borderRadius: BorderRadius.circular(7.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Object ${index+1}"),
                 )
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.blue,
        child: PopupMenuButton<SampleItem>(
          initialValue: selectedMenu,
          onSelected: (SampleItem item) {

            if(item == SampleItem.itemOne) {
              Navigator.push(context, CupertinoPageRoute(
                  builder: (_) => const AddScreen(objectId: "object1", objectName: "Object 1",)
              ));
            } else if(item == SampleItem.itemTwo) {
              Navigator.push(context, CupertinoPageRoute(
                  builder: (_) => const AddScreen(objectId: "object2", objectName: "Object 2",)
              ));
            } else if(item == SampleItem.itemThree) {
              Navigator.push(context, CupertinoPageRoute(
                  builder: (_) => const AddScreen(objectId: "object3", objectName: "Object 3",)
              ));
            }
          },

          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: Text('Object 1'),
            ),
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemTwo,
              child: Text('Object 2'),
            ),
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemThree,
              child: Text('Object 3'),
            ),
          ],
        ),
      ),
    );
  }
}
