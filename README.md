# Coffee Analyzer

A Flutter application for identifying coffee bean types and diagnosing potential issues by analyzing photos. This app uses machine learning and TensorFlow Lite for on-device image classification to recognize and categorize coffee beans based on the provided image.

## Features

- **Camera Integration**: Capture an image directly from the camera or select one from the gallery.
- **Image Preprocessing**: Resize and preprocess images to optimize them for machine learning inference.
- **Machine Learning Model**: Uses a TensorFlow Lite model to classify coffee beans and analyze potential issues.
- **Real-time Inference**: Processes the image in real-time and returns classification results with label probabilities.

## Code Structure

- **`main.dart`**: Initializes the app and sets up the home screen.
- **`GalleryScreen`**: Provides the UI for image capture, gallery selection, and displays the classification results.
- **`ImageClassificationHelper`**: Manages loading and processing the TensorFlow Lite model, performing inference, and handling input/output tensors.
- **`IsolateInference`**: Utilizes isolates to handle model inference in the background, enhancing performance on mobile devices.

## Usage

1. Launch the app, and choose between using the **Camera** or **Gallery** for image selection.
2. The app will display classification details, including the **type** of coffee bean and diagnostic insights, if any.
3. Review the model's input/output tensor shapes and classifications to understand the image analysis results better.
