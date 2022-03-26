import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  CameraDescription firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

// Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`


// Obtain a list of the available cameras on the device.


// Get a specific camera from the list of available cameras.


MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: buildMaterialColor(const Color(0xff934B00))).copyWith(secondary: buildMaterialColor(const Color(0xffBB6B00)))
      ),
      home: MyHomePage(camera: camera),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  void _cameraButton(File image) async{
    var uri = Uri.parse('http://192.168.0.31:8000/test/image');
    var bytes = await image.readAsBytes();
    List<int> list  =  List.from(bytes);
    var request = http.Request('PUT', uri);

    request.bodyBytes = list;
    request.headers[HttpHeaders.contentTypeHeader] = "image/jpg";

    var response = await request.send();
    if (response.statusCode == 200) print('Uploaded!');
    else print('Error');
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        title: Text('Sent $_counter photos'),
      ),
      body: Center(
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        child: FloatingActionButton(
          onPressed: () async {
            _controller.setFlashMode(FlashMode.off);
            var image = await _controller.takePicture();
            _cameraButton(File(image.path));
          },
          tooltip: 'Increment',

          child: const Icon(Icons.photo_camera_outlined),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: Row(
          children: [
            const Padding(padding: EdgeInsets.all(20.0)),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.check),
                  color: const Color(0x99FFFFFF),
                  onPressed: () {},
                ),
                const Text('FINISH', style: TextStyle(color: Color(0x99FFFFFF), letterSpacing: 1)),
                const Padding(padding: EdgeInsets.all(4.0))
              ],
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  color: const Color(0x99FFFFFF),
                  onPressed: () {},
                ),
                const Text('GALLERY', style: TextStyle(color: Color(0x99FFFFFF), letterSpacing: 1)),
                const Padding(padding: EdgeInsets.all(4.0))
              ],
            ),
            const Padding(padding: EdgeInsets.all(20.0))
          ],
        ),
      ),
    );
  }
}
