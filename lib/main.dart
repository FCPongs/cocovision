import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'translator.dart';
import 'camera.dart'; 
import 'statistics.dart'; 
import 'tutorial.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the language provider
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 1000,
                  height: 1000,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 47, 106, 49),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Start Button
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color.fromARGB(255, 57, 132, 60),
                        textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  TutorialPage()),
                        );
                      },
                      child: Text(languageProvider.isEnglish ? 'Start' : 'Simula'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Statistics Button
                  SizedBox(
                    width: 250,
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color.fromARGB(255, 63, 146, 66),
                        textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StatisticsPage()),
                        );
                      },
                      child: Text(languageProvider.isEnglish ? 'Statistics' : 'Estadistika'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Language Toggle Button
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: languageProvider.toggleLanguage,
                      child: Text(languageProvider.isEnglish
                          ? 'Switch to Filipino'
                          : 'Lumipat sa Ingles'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Text(
              languageProvider.isEnglish
                  ? "Developed & Created by Team Coco"
                  : "Gawa at Binuo ng Team Coco",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
