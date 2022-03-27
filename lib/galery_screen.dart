import 'package:briefcase_client/mockup.dart';
import 'package:briefcase_client/photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class GalleryScreen extends StatelessWidget {

  const GalleryScreen({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(category),
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(mockCategory[category]!.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        translate = 0;
                        Navigator.push((context),
                            MaterialPageRoute(builder:
                                (context) => PhotoScreen(category: category, number: index)));
                      },
                      child: Image.network(
                        ("http://3874-89-64-44-23.ngrok.io/images/" + mockCategory[category]![index]),
                        fit: BoxFit.fill,
                        scale: 0.1,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    );
          }),
        ),
    );
  }
}