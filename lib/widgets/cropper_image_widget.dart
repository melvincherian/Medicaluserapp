import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:medical_user_app/widgets/result_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:extended_image/extended_image.dart';

class CropperScreen extends StatefulWidget {
  final File imageFile;
  const CropperScreen({super.key, required this.imageFile});

  @override
  State<CropperScreen> createState() => _CropperScreenState();
}

class _CropperScreenState extends State<CropperScreen> {
  final GlobalKey<ExtendedImageEditorState> _editorKey =
      GlobalKey<ExtendedImageEditorState>();

  double? _aspectRatio;
  Size? _originalImageSize;
  Map<String, double> _aspectRatios = {};

  @override
  void initState() {
    super.initState();
    _loadOriginalImageSize();
  }

  void _loadOriginalImageSize() async {
    final data = await widget.imageFile.readAsBytes();
    final decodedImage = await decodeImageFromList(data);
    final originalWidth = decodedImage.width.toDouble();
    final originalHeight = decodedImage.height.toDouble();
    final originalRatio = originalWidth / originalHeight;

    setState(() {
      _originalImageSize = Size(originalWidth, originalHeight);
      _aspectRatios = {
        'Original': originalRatio,
        '1:1': 1.0,
        '16:9': 16 / 9,
        '9:16': 9 / 16,
        '7:5': 7 / 5,
        '5:7': 5 / 7,
      };
      _aspectRatio = originalRatio;
    });
  }

  void _cropAndNavigate() async {
    final state = _editorKey.currentState;
    if (state == null) return;

    final Uint8List? croppedData = await _cropImageDataWithDartLibrary(state);

    if (croppedData == null) {
      print("Cropping failed");
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final filePath =
        '${tempDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(croppedData);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(imageFile: file),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_aspectRatios.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final aspectRatio = _aspectRatio == 0.0 ? null : _aspectRatio;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF5931DD),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Crop Image", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
              icon: const Icon(Icons.check, color: Colors.white),
              onPressed: _cropAndNavigate),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ExtendedImage.file(
                widget.imageFile,
                fit: BoxFit.contain,
                mode: ExtendedImageMode.editor,
                extendedImageEditorKey: _editorKey,
                initEditorConfigHandler: (state) {
                  return EditorConfig(
                    maxScale: 8.0,
                    cropRectPadding: const EdgeInsets.all(20.0),
                    hitTestSize: 20.0,
                    cropAspectRatio: aspectRatio,
                  );
                },
                cacheRawData: true,
              ),
            ),
            _buildAspectRatioSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildAspectRatioSelector() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.black,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _aspectRatios.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ChoiceChip(
              label: Text(entry.key, style: const TextStyle(color: Colors.white)),
              selected: _aspectRatio == entry.value,
              onSelected: (_) => setState(() => _aspectRatio = entry.value),
              selectedColor: Colors.white24,
              backgroundColor: Colors.grey[800],
              labelStyle: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<Uint8List?> _cropImageDataWithDartLibrary(
      ExtendedImageEditorState state) async {
    final Rect cropRect = state.getCropRect()!;
    final Uint8List data = state.rawImageData!;
    final ui.Image image = await decodeImageFromList(data);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    final srcRect = cropRect;
    final dstRect = Rect.fromLTWH(0, 0, cropRect.width, cropRect.height);

    canvas.drawImageRect(image, srcRect, dstRect, paint);

    final picture = recorder.endRecording();
    final ui.Image croppedImage = await picture.toImage(
      cropRect.width.toInt(),
      cropRect.height.toInt(),
    );

    final byteData =
        await croppedImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }
}