import 'package:flutter/material.dart';
import 'camera.dart'; 
import 'statistics.dart'; 

void main() {
  runApp(const MyApp());
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
                          MaterialPageRoute(builder: (context) => const CameraPage()),
                        );
                      },
                      child: const Text('Start'),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      child: const Text('Statistics'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: const Text(
              "Developed & Created by Team Coco",
              style: TextStyle(
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
