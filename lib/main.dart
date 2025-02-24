import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'translator.dart';
import 'camera.dart';
import 'statistics.dart';
import 'tutorial.dart';
import 'shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Required to run async code in main
  await SharedPreferencesHelper().initPreferences();
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
    final ValueNotifier<bool> _direction = ValueNotifier(true);

    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 239, 232, 1.0),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),

          //! Column 1: Logo
          Center(
            child: ValueListenableBuilder<bool>(
              valueListenable: _direction,
              builder: (context, isMovingUp, child) {
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                      begin: isMovingUp ? 10 : -10, end: isMovingUp ? -10 : 20),
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.easeInOut,
                  onEnd: () {
                    _direction.value = !_direction.value; 
                  },
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, value), 
                      child: child,
                    );
                  },
                  child: Image.asset('assets/logo.png'),
                );
              },
            ),
          ),
          //! Column 3: Buttons
          Column(
            children: [
              Container(
                width: 360,
                height: 40,
                  child: const Center(
                    child: Text(
                      "Lets begin our journey here!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 49, 49)),
                      
                      ),
                  ),
              ),
              SizedBox(height: 0,),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: 360,
                      height: 300,
                      child: Card(
                        elevation: 10,
                        color: Color.fromRGBO(202, 218, 191, 5),
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 250,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor:
                                        const Color.fromARGB(255, 57, 132, 60),
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TutorialPage()),
                                    );
                                  },
                                  child: Text(languageProvider.isEnglish
                                      ? 'Start'
                                      : 'Simula'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 250,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor:
                                        const Color.fromARGB(255, 63, 146, 66),
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const StatisticsPage()),
                                    );
                                  },
                                  child: Text(languageProvider.isEnglish
                                      ? 'Statistics'
                                      : 'Estadistika'),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 250,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    foregroundColor:
                                        const Color.fromARGB(255, 0, 0, 0),
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
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
                    ),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    languageProvider.isEnglish
                        ? "Developed & Created by Team Coco"
                        : "Gawa at Binuo ng Team Coco",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
