import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SleepData extends StatefulWidget {
  const SleepData({super.key, required this.sleepData});
final List<double> sleepData;
  @override
  State<SleepData> createState() => _SleepDataState();
}

class _SleepDataState extends State<SleepData> {
  
  @override
  Widget build(BuildContext context) {
    
return Container( height: 50,  padding: EdgeInsets.only(left: 15, right: 15),
child: BarChart(  
BarChartData(
barGroups: getBars(),
titlesData: FlTitlesData(show: false), 
borderData: FlBorderData(show: false), 
gridData: FlGridData(show: false),
barTouchData: BarTouchData(enabled: true,
touchTooltipData: BarTouchTooltipData(
getTooltipItem: (group, groupIndex, rod, rodIndex) {
return BarTooltipItem(
"${rod.toY} hrs",
TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
);
},),
),

),
duration: Duration(milliseconds: 1000),
curve: Curves.easeInOut,
),
  );

  }


List<BarChartGroupData> getBars(){
 return List.generate(widget.sleepData.length, (index){
return BarChartGroupData(x: index,
barRods: [
 BarChartRodData(
toY: widget.sleepData[index], 
color: Color(0xFF3F2B57), 
width: 10, 
borderRadius: BorderRadius.circular(5),
),
]
);
 });
}
}