import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key, required this.selectedDay, required this.focusedDay});
final DateTime selectedDay;
final DateTime focusedDay;
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<String>> events = {};
final currentDate = DateTime.now();
@override
  void initState() {
super.initState();
focusedDay = DateTime.now();

}
  @override
  Widget build(BuildContext context) {
final theme = Theme.of(context);
return TableCalendar(focusedDay: focusedDay, rowHeight: 60, firstDay: DateTime(2025), lastDay: DateTime(2040), calendarFormat: format, selectedDayPredicate: (day) => isSameDay(selectedDay, day),
headerStyle: HeaderStyle(
titleCentered: false, formatButtonVisible: false, headerPadding: EdgeInsets.only(left: 20),
titleTextStyle: theme.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900), leftChevronVisible: false, rightChevronVisible: false,
),
onDaySelected: (selectedDay, focusedDay) {
setState(() { selectedDay = selectedDay; focusedDay = focusedDay; });
}, daysOfWeekHeight: 0, calendarBuilders: CalendarBuilders(
defaultBuilder: (context, day, focusedDay) {
return _buildDateContainer(day);
},
todayBuilder: (context, day, focusedDay) {
return _buildDateContainer(day, isToday: true);
},
selectedBuilder: (context, day, focusedDay) {
return _buildDateContainer(day, isSelected: true);
},
),
);
  }

  Widget _buildDateContainer(DateTime day,{bool isToday = false, bool isSelected = false}) {
return SizedBox( height: 55,
  child: Container(
  margin: EdgeInsets.all(4),
  decoration: BoxDecoration(
  color: isSelected
  ? Colors.black
  : isToday
  ? Colors.orange
  : Theme.of(context).primaryColor,
  borderRadius: BorderRadius.all(Radius.elliptical(12, 12))
  ),
  alignment: Alignment.center, child: Column(
  children: [
  Padding(
padding: const EdgeInsets.only(top: 4),
child: Text(
_getWeekday(day.weekday),style: TextStyle(
fontSize: 12,
fontWeight: FontWeight.bold,
color: isSelected || isToday ? Colors.white : Colors.black,
    ),
    ),
  ),
  Padding(
padding: const EdgeInsets.only(bottom: 4),
child: Text(
"${day.day}",
style: TextStyle(
fontSize: 14,
fontWeight: FontWeight.bold,
color: isSelected || isToday ? Colors.white : Colors.black,
),
),
),
],
  ),
  ),
);
}

String _getWeekday(int weekday) {
const weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
return weekdays[weekday - 1];
  }
}