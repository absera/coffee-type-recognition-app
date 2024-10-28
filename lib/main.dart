import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'ui/gallery.dart';

Future<void> main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraDescription cameraDescription;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("የቡና ፍሬ መለያ መተግበሪያ"),
        backgroundColor: Colors.brown,
      ),
      body: const Center(
        child: GalleryScreen(),
      ),
    );
  }
}
