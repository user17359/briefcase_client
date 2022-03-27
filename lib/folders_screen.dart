import 'package:briefcase_client/galery_screen.dart';
import 'package:briefcase_client/mockup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FoldersScreen extends StatelessWidget {

  const FoldersScreen({Key? key,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Browse files'),
      ),
      body: ListView.builder(
          itemCount: mockCategory.keys.length,
          itemBuilder: (context, index) {
            return ListTile(
                onTap: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder:
                          (context) => GalleryScreen(category: mockCategory.keys.elementAt(index))));
                },
                title: Text(mockCategory.keys.elementAt(index)),
                subtitle: mockCategory.keys.isNotEmpty ? Text("${mockCategory[mockCategory.keys.elementAt(index)]!.length} photos") : Text("0 photos"),
                leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primary));
          })
    );
  }
}