import 'package:flutter/material.dart';
import 'camera.dart'; 
import 'package:provider/provider.dart';
import 'translator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TutorialPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TutorialPage extends StatelessWidget {
  final List<String> images = [
    'assets/tutorial1.jpg',
    'assets/tutorial2.jpg',
    'assets/tutorial3.jpg',
    'assets/tutorial4.png',
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: (height * 4) / 5,
                child: PageView.builder(
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      images[index],
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
              // Swipe Left Indicator
              Positioned(
                left: 16,
                bottom: 16,
                child: Row(
                  children: [
                    Icon(Icons.swipe, color: Colors.white, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      languageProvider.isEnglish
                          ? 'Swipe left to continue'
                          : 'Mag-swipe pakaliwa para magpatuloy',
                      style: TextStyle(
                        color: Colors.yellow[900],
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.green[800],
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.lightGreen,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  onPressed: () {
                    // Navigate to CameraPage when button is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraPage()),
                    );
                  },
                  child: Text(
                    languageProvider.isEnglish
                        ? 'Get Started'
                        : 'Magsimula',
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
