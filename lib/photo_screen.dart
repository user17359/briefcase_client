import 'package:briefcase_client/galery_screen.dart';
import 'package:briefcase_client/mockup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

int translate = 0;

class PhotoScreen extends StatefulWidget {

  const PhotoScreen({Key? key, required this.category, required this.number})
      : super(key: key);

  final String category;
  final int number;

  @override
  State<PhotoScreen> createState() => _PhotoScreen();
}

class _PhotoScreen extends State<PhotoScreen> {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: const Text('Browse files'),
        ),
        body: SizedBox.expand(
          child: Dismissible(
            confirmDismiss: (direction) async{
              setState(() {
                print(direction);
                if((direction == DismissDirection.endToStart) && ((translate + widget.number + 1) < mockCategory[widget.category]!.length)){
                  translate += 1;
                  print("going right");
                }
                print(direction);
                if((direction == DismissDirection.startToEnd) && (translate + widget.number) > 0){
                  translate -= 1;
                  print("going left");
                }
                else{
                  translate = translate;
                }
                });
            },

            secondaryBackground: ((translate + widget.number + 1) < mockCategory[widget.category]!.length) ? Image.network(
              ("http://3874-89-64-44-23.ngrok.io/images/" + mockCategory[widget.category]![widget.number + translate + 1]),
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
              ) : Container(color: Colors.white),

            background: (translate + widget.number) > 0 ? Image.network(
              ("http://3874-89-64-44-23.ngrok.io/images/" + mockCategory[widget.category]![widget.number + translate - 1]),
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
            ) : Container(color: Colors.white),


            key: new ValueKey(translate),
            child: Row(
              children: [
                Expanded(
                  child: Image.network(
                    ("http://3874-89-64-44-23.ngrok.io/images/" + mockCategory[widget.category]![widget.number + translate]),
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
                ),
              ],
            ),
          ),
        ),
    );
  }
}