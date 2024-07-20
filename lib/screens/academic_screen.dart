

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MaterialApp(
    home: AcademicScreen(),
  ));
}

class AcademicScreen extends StatefulWidget {
  @override
  _AcademicScreenState createState() => _AcademicScreenState();
}

class _AcademicScreenState extends State<AcademicScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {};


  DateTime? _lastSelectedDay;
  int _clickCount = 0;

  
  void _navigateToEventScreen(DateTime date) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventScreen(date: date, events: _events[date] ?? []),
      ),
    );

    if (result != null) {
      setState(() {
        _events[date] = result;
      });
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (_lastSelectedDay == null ||
        !isSameDay(selectedDay, _lastSelectedDay)) {
      _lastSelectedDay = selectedDay;
      _clickCount = 1;
    } else {
      _clickCount++;
    }

    if (_clickCount == 2) {
      _navigateToEventScreen(selectedDay);
      _clickCount = 0;
    }

    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 01, 01),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            onDaySelected: (selectedDay, focusedDay) {
              _onDaySelected(selectedDay, focusedDay);
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
            
                bool isSunday = day.weekday == DateTime.sunday;
                bool hasEvent = _events[day]?.isNotEmpty ?? false;

                return Center(
                  child: Column(
                    children: [
                      Text(
                        '${day.day}',
                        style: TextStyle(
                          color: isSunday ? Colors.red : Colors.black,
                          fontWeight: isSunday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (hasEvent) ...[
                        Icon(Icons.event, size: 10, color: Colors.blue),
                      ]
                    ],
                  ),
                );
              },
              todayBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(6.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(6.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${day.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display events for selected day
                  ...(_events[_selectedDay] ?? []).map((event) => ListTile(
                    title: Text(event),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventScreen extends StatefulWidget {
  final DateTime date;
  final List<String> events;

  EventScreen({required this.date, required this.events});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final TextEditingController _controller = TextEditingController();
  late List<String> _events;

  @override
  void initState() {
    super.initState();
    _events = widget.events;
  }

  void _addEvent() {
    setState(() {
      _events.add(_controller.text);
      _controller.clear();
    });
  }

  void _removeEvent(int index) {
    setState(() {
      _events.removeAt(index);
    });
  }

  void _saveEvents() {
    Navigator.pop(context, _events);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events on ${widget.date.toLocal()}'.split(' ')[0]),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveEvents,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter event',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addEvent,
              child: Text('Add Event'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_events[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeEvent(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
