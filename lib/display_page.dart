import 'package:flutter/material.dart';
import 'dart:typed_data';

class DisplayPage extends StatelessWidget {
  final Uint8List imageBytes;
  final Duration apiDuration;
  final String ramUsage;

  const DisplayPage({
    Key? key,
    required this.imageBytes,
    required this.apiDuration,
    required this.ramUsage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/logo.png', 
            height: 40, 
          ),
          const SizedBox(width: 10), 
          Text(
            'Prediction Result',
            style: const TextStyle(
              fontSize: 20, // Larger font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.lightGreen,
    ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(16.0),
        color: Colors.green[800],
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display API duration
              Text(
                'Time taken: ${apiDuration.inMilliseconds} ms',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20), // Spacing

              // Display RAM usage
              Text(
                'RAM Usage: $ramUsage',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20), // Spacing

              
              // Display the image
              imageBytes.isNotEmpty
                  ? Image.memory(
                      imageBytes,
                      fit: BoxFit.contain,
                      height: 300,
                    )
                  : const Text(
                      'No image to display',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
