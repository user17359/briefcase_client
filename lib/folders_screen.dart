import 'package:briefcase_client/mockup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

List<List<String>> imageLinks = [];

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
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(mockCategory.keys.elementAt(index) + ' pressed!'),
                  ));
                },
                title: Text(mockCategory.keys.elementAt(index)),
                subtitle: Text("${mockCategory[mockCategory.keys.elementAt(index)]!.length} photos"),
                leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primary));
          })
    );
  }
}