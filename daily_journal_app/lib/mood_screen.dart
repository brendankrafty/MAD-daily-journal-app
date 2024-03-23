import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'entry_data.dart';
import 'database_helper.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  _MoodScreenState createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  DBHelper dbHelper = DBHelper();
  List<Entry> entries = [];

  @override
  void initState() {
    super.initState();
    loadEntries();
  }

  void loadEntries() async {
    entries = await dbHelper.readAllEntries();
    setState(() {});
  }

  List<FlSpot> getSpots() {
    return entries
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), (entry.value.moodRating ?? 0).toDouble()))
        .toList();
  }

  LineChartBarData getLine() {
    return LineChartBarData(
      spots: getSpots(),
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
    return CustomScaffold(
      //selectedIndex: 0,
      body: Center(
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
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [getLine()],
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
                  ),)
              ],
            )
        ),
      ),
    );
  }
}
