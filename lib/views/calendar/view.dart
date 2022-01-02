import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/extensions/date_time.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final List<Recording> recordings;

  const Calendar(this.recordings, {Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(DateTime.now().year, DateTime.now().month, 1),
      lastDay: DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 0),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      eventLoader: (day) => widget.recordings.where((recording) => recording.date.isSameDate(day)).map((recording) => recording.name).toList(),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}