import 'dart:io';

import 'package:briefcase_client/mockup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:briefcase_client/folders_screen.dart';


Batch test = Batch();
Batch display = Batch();

class ProgressScreen extends StatefulWidget{

  const ProgressScreen({Key? key, required this.total}) : super(key: key);

  final int total;


  @override
  State<ProgressScreen> createState() => _ProgressScreenState();

}


class _ProgressScreenState extends State<ProgressScreen> {

  void refresh(bool complete) {
    if(complete)
    {
      Navigator.push((context),
          MaterialPageRoute(builder:
              (context) => FoldersScreen(),));
    }
    setState(() {});
  }

  @override
  void initState() {
    mockBatch(test);
    getStatus(test, display, 1, refresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Processing"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            children: [
              const Spacer(),
              Text("${display.progress} of ${display.total} images processed", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20)),
              const Padding(padding: EdgeInsets.all(5.0)),
              LinearProgressIndicator(
                value: (display.progress/display.total).isFinite ? (display.progress/display.total) : 0,
                semanticsLabel: 'Linear progress indicator',
              ),
              const Spacer()
            ],
          ),
        )
      ),
    );
  }
}