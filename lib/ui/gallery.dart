import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import '../helper/classifier.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  ImageClassificationHelper? imageClassificationHelper;
  final imagePicker = ImagePicker();
  String? imagePath;
  img.Image? image;
  Map<String, double>? classification;

  @override
  void initState() {
    imageClassificationHelper = ImageClassificationHelper();
    imageClassificationHelper!.initHelper();
    super.initState();
  }

  // Clean old results when press some take picture button
  void cleanResult() {
    imagePath = null;
    image = null;
    classification = null;
    setState(() {});
  }

  // Process picked image
  Future<void> processImage() async {
    if (imagePath != null) {
      // Read image bytes from file
      final imageData = File(imagePath!).readAsBytesSync();

      // Decode image using package:image/image.dart (https://pub.dev/image)
      image = img.decodeImage(imageData);
      final resizedImage = img.copyResize(image!, width: 100, height: 100);

      setState(() {});
      classification = await imageClassificationHelper?.inferenceImage(resizedImage!);

      setState(() {});
    }
  }

  @override
  void dispose() {
    imageClassificationHelper?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () async {
                  cleanResult();
                  final result = await imagePicker.pickImage(
                    source: ImageSource.camera,
                  );

                  imagePath = result?.path;
                  setState(() {});
                  processImage();
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                  color: Colors.brown,
                ),
                label: const Text("ካሜራ ይጠቀሙ", style: TextStyle(color: Colors.brown),),
              ),
              TextButton.icon(
                onPressed: () async {
                  cleanResult();
                  final result = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                  );

                  imagePath = result?.path;
                  setState(() {});
                  processImage();
                },
                icon: const Icon(
                  Icons.photo_outlined,
                  size: 30,
                  color: Colors.brown,
                ),
                label: const Text("ከጋለሪ ይምረጡ", style: TextStyle(color: Colors.brown),),
              ),
            ],
          ),
          const Divider(),
          Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (imagePath != null) Image.file(File(imagePath!)),
                  if (image == null)
                    const Text("የቡና ፍሬ ፎቶ ያስገቡ።"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(),
                      if (image != null) ...[
                        // Show model information
                        if (imageClassificationHelper?.inputTensor != null)
                          Text(
                            'Input: (shape: ${imageClassificationHelper?.inputTensor.shape})',
                          ),
                        if (imageClassificationHelper?.outputTensor != null)
                          Text(
                            'Output: (shape: ${imageClassificationHelper?.outputTensor.shape} )',
                          ),
                        const SizedBox(height: 8),
                        // Show picked image information
                        Text('Image Height: ${image?.height}'),
                        Text('Image Width: ${image?.width}'),
                        Text('Bean Class: ${classification?.keys.first}', style: TextStyle(fontSize: 20,color: Colors.green), ),
                      ],
                      const Spacer(),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}