import 'package:fluent/repository.dart'; // Assuming you have your ModelRepository here
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ChartData> _chartData = [];

  @override
  void initState() {
    super.initState();
    _prepareChartData();
  }

  // Prepare the chart data and assign color based on duplicate IDs
  void _prepareChartData() {
    Map<String, int> groupedData = {};
    Map<String, int> idOccurrences = {};  // Store occurrences of each ID

    // Group by time and count occurrences of IDs
    for (var user in list) {
      String timeKey = DateFormat('yyyy-MM-dd HH:mm').format(user.time);
      groupedData[timeKey] = (groupedData[timeKey] ?? 0) + 1;

      // Count occurrences of IDs
      idOccurrences[user.id.toString()] = (idOccurrences[user.id.toString()] ?? 0) + 1;
    }

    // Create chart data based on grouped data
    setState(() {
      _chartData = groupedData.entries.map((entry) {
        String idKey = entry.key;
        bool isRed = idOccurrences[idKey] != null && idOccurrences[idKey]! > 1;
        return ChartData(entry.key, entry.value, isRed);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chart Filter"),
      ),
      body: _chartData.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while data is being processed
          : SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: 'Time'),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: 'User Count'),
        ),
        title: const ChartTitle(text: 'User Activity Over Time'),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: _chartData, // Use the chart data
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.count,
            pointColorMapper: (ChartData data, _) =>
            data.isRed ? Colors.red : Colors.blue,  // Set color based on condition
            name: 'Users',
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }
}

// ChartData class for storing the data for chart representation
class ChartData {
  final String time;
  final int count;
  final bool isRed; // Add a flag to indicate if the bar should be red

  ChartData(this.time, this.count, this.isRed);
}


// import 'package:fluent/repository.dart'; // Assuming you have your ModelRepository here
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:intl/intl.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   List<ChartData> _chartData = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _prepareChartData();
//   }
//
//   void _prepareChartData() {
//     Map<String, int> groupedData = {};
//
//     for (var user in list) {
//       String key = DateFormat('yyyy-MM-dd HH:mm').format(user.time);
//       groupedData[key] = (groupedData[key] ?? 0) + 1;
//     }
//     setState(() {
//       _chartData = groupedData.entries.map((entry) => ChartData(entry.key, entry.value)).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Chart Filter"),
//       ),
//       body: _chartData.isEmpty
//           ? const Center(child: CircularProgressIndicator()) // Show loading indicator while data is being processed
//           : SfCartesianChart(
//         primaryXAxis: const CategoryAxis(
//           title: AxisTitle(text: 'Time'),
//         ),
//         primaryYAxis: const NumericAxis(
//           title: AxisTitle(text: 'User Count'),
//         ),
//         title: const ChartTitle(text: 'User Activity Over Time'),
//         series: <CartesianSeries>[
//           ColumnSeries<ChartData, String>(
//             dataSource: _chartData, // Use the chart data
//             xValueMapper: (ChartData data, _) => data.time,
//             yValueMapper: (ChartData data, _) => data.count,
//             name: 'Users',
//             dataLabelSettings: const DataLabelSettings(isVisible: true),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// // ChartData class for storing the data for chart representation
// class ChartData {
//   final String time;
//   final int count;
//
//   ChartData(this.time, this.count);
// }
