import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'translator.dart'; // Ensure you have this provider implemented
import 'shared_preferences.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late Map<String, dynamic> stats;
  final prematureCounter = SharedPreferencesHelper().getIntValue('premature');

  @override
  void initState() {
    super.initState();
    stats = {
      'detected': {
        'total': 0,
        'premature': 0,
        'mature': 0,
        'overly_matured': 0,
        'today': 0,
        'this_week': 0,
        'this_month': 0,
        'this_year': 0,
        'most_in_a_day': 0,
        'most_in_a_week': 0,
        'most_in_a_month': 0,
        'most_in_a_year': 0,
      },
      'photos': {
        'total': 0,
        'photos_taken': 0,
        'photos_uploaded': 0,
        'today': 0,
        'this_week': 0,
        'this_month': 0,
        'this_year': 0,
        'most_in_a_day': 0,
        'most_in_a_week': 0,
        'most_in_a_month': 0,
        'most_in_a_year': 0,
      },
    };

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final photosTaken = SharedPreferencesHelper().getCounter('picturesTaken');
      final photosUploaded = SharedPreferencesHelper().getCounter('doneClicked');
      // Add logic to retrieve the values for 'detected'
      final prematureDetected = SharedPreferencesHelper().getCounter('premature');
      final maturedDetected = SharedPreferencesHelper().getCounter('matured');
      final overlyMaturedDetected = SharedPreferencesHelper().getCounter('overlyMatured');
      
      setState(() {
        stats['photos']['photos_taken'] = photosTaken;
        stats['photos']['photos_uploaded'] = photosUploaded;
        stats['detected']['premature'] = prematureDetected;
        stats['detected']['mature'] = maturedDetected;
        stats['detected']['overly_matured'] = overlyMaturedDetected;

        // Calculate total detected count
        stats['detected']['total'] = prematureDetected + maturedDetected + overlyMaturedDetected;

        // Calculate total photos count
        stats['photos']['total'] = photosTaken + photosUploaded;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isEnglish = languageProvider.isEnglish;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEnglish ? 'Statistics' : 'Istatistika'),
      ),
      body: Container(
        color: Color.fromRGBO(33, 49, 49, 1.0),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEnglish ? 'Detected and Classified' : 'Nadetect at Nakategorya',
                style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              _buildStatisticsSection(
                isEnglish: isEnglish,
                stats: stats['detected'],
                category: 'detected',
                labels: {
                  'total': ['Total', 'Kabuuan'],
                  'premature': ['Premature (Stage 1)', 'Maagang Hinog (Yugto 1)'],
                  'mature': ['Mature (Stage 2)', 'Hinog (Yugto 2)'],
                  'overly_matured': ['Overly Matured (Stage 3)', 'Sobrang Hinog (Yugto 3)'],
                  'today': ['Today', 'Ngayon'],
                  'this_week': ['This Week', 'Ngayong Linggo'],
                  'this_month': ['This Month', 'Ngayong Buwan'],
                  'this_year': ['This Year', 'Ngayong Taon'],
                  'most_in_a_day': ['Most in a Day', 'Pinakamarami sa Isang Araw'],
                  'most_in_a_week': ['Most in a Week', 'Pinakamarami sa Isang Linggo'],
                  'most_in_a_month': ['Most in a Month', 'Pinakamarami sa Isang Buwan'],
                  'most_in_a_year': ['Most in a Year', 'Pinakamarami sa Isang Taon'],
                },
              ),
              const SizedBox(height: 20),
              Text(
                isEnglish ? 'Photos' : 'Mga Larawan',
                style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              _buildStatisticsSection(
                isEnglish: isEnglish,
                stats: stats['photos'],
                category: 'photos',
                labels: {
                  'total': ['Total', 'Kabuuan'],
                  'photos_taken': ['Photos Taken', 'Mga Larawang Kinuha'],
                  'photos_uploaded': ['Photos Uploaded', 'Mga Larawang Na-upload'],
                  'today': ['Today', 'Ngayon'],
                  'this_week': ['This Week', 'Ngayong Linggo'],
                  'this_month': ['This Month', 'Ngayong Buwan'],
                  'this_year': ['This Year', 'Ngayong Taon'],
                  'most_in_a_day': ['Most in a Day', 'Pinakamarami sa Isang Araw'],
                  'most_in_a_week': ['Most in a Week', 'Pinakamarami sa Isang Linggo'],
                  'most_in_a_month': ['Most in a Month', 'Pinakamarami sa Isang Buwan'],
                  'most_in_a_year': ['Most in a Year', 'Pinakamarami sa Isang Taon'],
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsSection({
    required bool isEnglish,
    required Map<String, dynamic> stats,
    required String category,
    required Map<String, List<String>> labels,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: labels.entries.map((entry) {
        final key = entry.key;
        final label = isEnglish ? entry.value[0] : entry.value[1];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              title: Text(
                label,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                stats[key]?.toString() ?? '0',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
