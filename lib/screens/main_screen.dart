import 'package:floordatabaseproject/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      body: ListView.builder(
        itemCount: 5,
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
                      builder: (_) => HomeScreen(id: "object${index+1}")
                    ));
                  },
                  borderRadius: BorderRadius.circular(7.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${index+1} object"),
                 )
              ),
            ),
          );
        },
      ),
    );
  }
}
