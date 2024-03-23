import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'entry_data.dart';
import 'database_helper.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({Key? key}) : super(key: key);

  @override
  _MoodScreenState createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  DBHelper dbHelper = DBHelper();
  Future<List<Entry>>? entriesFuture;

  @override
  void initState() {
    super.initState();
    entriesFuture = dbHelper.readAllEntries();
  }

  List<FlSpot> getSpots(List<Entry> entries) {
    return entries
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), (entry.value.moodRating ?? 0).toDouble()))
        .toList();
  }

  LineChartBarData getLine(List<Entry> entries) {
    return LineChartBarData(
      spots: getSpots(entries),
      isCurved: true,
      color: Colors.blue,
      barWidth: 5,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Mood Chart',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Entry>>(
                    future: entriesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Error loading entries');
                      } else {
                        return LineChart(
                          LineChartData(
                            lineBarsData: [getLine(snapshot.data!)],
                            minY: 1,
                            maxY: 10,
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) => Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Day ${value.toInt()}',
                                      style: const TextStyle(
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) => Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      '${value.toInt()}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              getDrawingHorizontalLine: (value) => const FlLine(
                                color: Colors.black26,
                                strokeWidth: 1,
                              ),
                              getDrawingVerticalLine: (value) => const FlLine(
                                color: Colors.black26,
                                strokeWidth: 1,
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}