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
    'assets/tutorial1.1.jpg',
    'assets/tutorial2.1.jpg',
    'assets/tutorial3.1.jpg',
    'assets/tutorial4.1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: (height * 3.3) / 5,
                child: PageView.builder(
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),

              // Back Button
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: const Color.fromARGB(255, 0, 0, 0), size: 28),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              // Swipe Left Indicator
              Positioned(
                left: 16,
                bottom: 16,
                child: Row(
                  children: [
                    Icon(Icons.swipe,
                        color: const Color.fromRGBO(148, 158, 144, 1.0),
                        size: 28),
                    const SizedBox(width: 8),
                    Text(
                      languageProvider.isEnglish
                          ? 'Swipe left to continue'
                          : 'Mag-swipe pakaliwa para magpatuloy',
                      style: TextStyle(
                        color: Color.fromRGBO(148, 158, 144, 1.0),
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
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                color: Color.fromRGBO(202, 218, 191,
                    5), //Color.fromRGBO(33, 49, 49, 1.0) Color.fromRGBO(202, 218, 191, 5)
                child: Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        Text(
                          languageProvider.isEnglish
                              ? "Spot the perfect coconut, let’s go! 🌴"
                              : "Hanapin ang tamang niyog, simulan na",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(33, 49, 49, 1.0),
                            letterSpacing: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 310,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.lightGreen,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), 
                              ),
                            ),
                            onPressed: () {
                             
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CameraPage()),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.eco, color: Colors.green, size: 28),
                                SizedBox(width: 10),
                                Text(
                                  languageProvider.isEnglish
                                      ? 'Get Started'
                                      : 'Magsimula',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
