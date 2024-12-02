import 'dart:convert';

import 'package:CocoVision/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'package: device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data'; // Import for Uint8List
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:system_info2/system_info2.dart';
import 'display_page.dart';
import 'package:provider/provider.dart';
import 'translator.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final CropController _cropController = CropController();
  bool _isCropping = false;
  Uint8List? _croppedImage;


  

Future<void> _takePicture() async {
  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

  // Check if the user successfully took a picture
  if (photo != null) {
    SharedPreferencesHelper().incrementCounter('picturesTaken');

    setState(() {
      _isCropping = true; // Show cropping UI
      _image = File(photo.path);
    });
  } else {
    print('User did not capture an image.');
  }
}


  Future<void> _uploadPicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        _isCropping = true; // Show cropping UI
        _image = File(photo.path);
      });
    }
  }

  void _onCropDone(Uint8List croppedData) {
    setState(() {
      _croppedImage = croppedData;
      _isCropping = false; // Exit cropping UI
    });
  }

Future<void> _sendImageToServer() async {
  if (_croppedImage == null) return;

  var uri = Uri.parse('http://192.168.100.115:5000/predict'); 
  var request = http.MultipartRequest('POST', uri);

  // Attach the cropped image to the request
  request.files.add(
    http.MultipartFile.fromBytes(
      'image',
      _croppedImage!,
      contentType: MediaType('image', 'jpeg'),
      filename: 'cropped_image.jpg',
    ),
  );

  try {
    final startTime = DateTime.now(); 
    var response = await request.send().timeout(Duration(seconds: 30));
    final endTime = DateTime.now(); // Stop timing after response
    final apiDuration = endTime.difference(startTime); // Calculate API duration
    final totalPhysicalMemory = SysInfo.getTotalPhysicalMemory();
    final freePhysicalMemory = SysInfo.getFreePhysicalMemory();
    final ramUsage =
        '${((totalPhysicalMemory - freePhysicalMemory) / totalPhysicalMemory * 100).toStringAsFixed(2)}%';

    // Get CPU usage (placeholder, requires custom implementation)

     if (response.statusCode == 200) {
    // Parse the response body
    var responseBody = await response.stream.bytesToString();
    final parsedResponse = jsonDecode(responseBody);

    // Extract imageBytes (decode base64 image) and categoryCounts
    final Uint8List imageBytes = base64Decode(parsedResponse['image']);
    final Map<String, int> categoryCounts = Map<String, int>.from(parsedResponse['category_counts']);


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DisplayPage(imageBytes: imageBytes, apiDuration: apiDuration, ramUsage: ramUsage, categoryCounts: categoryCounts,),
        ),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.statusCode}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 70,
              width: 70,
            ),
            const SizedBox(width: 10),
            Expanded( 
              child: const Text(
                'CocoVision',
                overflow: TextOverflow.ellipsis, 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
  body: Container(
  width:  double.infinity,
  height: double.infinity,
  color: Colors.green[700], 
  child: _isCropping
      ? Center(
          child: Column(
            children: [
              Expanded(
                child: Crop(
                  controller: _cropController,
                  image: _image!.readAsBytesSync(),
                  onCropped: _onCropDone,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                  SharedPreferencesHelper().incrementCounter('doneClicked');
                  _cropController.crop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellowAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text(
                      languageProvider.isEnglish
                          ? 'Done'
                          : 'Tapos',
                      style: const TextStyle(fontSize: 24, color:Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
              ),
            ],
          ),
        )
      : SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_croppedImage != null)
                Image.memory(_croppedImage!)
              else if (_image != null)
                Image.file(_image!)
              else
                Padding(
                  padding: const EdgeInsets.all(20),
                      child: Text(
                      languageProvider.isEnglish
                          ? '--No Image Selected--'
                          : '--Walang Napiling Larawan--',
                      style: const TextStyle(fontSize: 24, color:Colors.red, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _takePicture,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellowAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text(
                  languageProvider.isEnglish
                      ? 'Capture an Image'
                      : 'Kumuha ng Larawan',
                  style: const TextStyle(fontSize: 24, color:Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadPicture,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text(
                  languageProvider.isEnglish
                      ? 'Upload from Gallery'
                      : 'Mag-upload mula sa Pictures',
                  style: const TextStyle(fontSize: 24, color:Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendImageToServer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text(
                  languageProvider.isEnglish
                      ? 'Start Picture Scanning'
                      : 'Simulan ang Pag-scan ng larawan',
                  style: const TextStyle(fontSize: 24, color:Colors.black, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
),
    );
  }
}
