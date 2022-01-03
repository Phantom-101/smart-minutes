import 'package:flutter/material.dart';
import 'package:meeting_minutes/data/recording.dart';
import 'package:meeting_minutes/extensions/date_time.dart';
import 'package:meeting_minutes/views/recordings/recording_info/view.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final List<Recording> recordings;

  const Calendar(this.recordings, {Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Card(
          child: TableCalendar(
            firstDay: DateTime.utc(2000),
            lastDay: DateTime.utc(DateTime.now().year + 100),
            focusedDay: _focusedDay,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            eventLoader: (day) => widget.recordings.where((recording) => recording.date.isSameDate(day)).toList(),
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
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
        ),
        ...widget.recordings.where((recording) => recording.date.isSameDate(_selectedDay ?? _focusedDay)).map((recording) => RecordingInfo(recording)),
      ],
    );
  }
}