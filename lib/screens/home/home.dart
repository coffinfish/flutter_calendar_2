// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_calendar_2/ui/pages/view_event.dart';
import 'package:flutter_calendar_2/res/event_firestore_service.dart';
import 'package:flutter_calendar_2/services/auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendar_2/models/event.dart';

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("home"),
//     );
//   }
// }
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) {
        data[date] = [];
      }
      data[date].add(event);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calendar'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Log Out'),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () async {
              await _auth.logout();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<EventModel>>(
          stream: eventDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              } else {
                _events = {};
                _selectedEvents = [];
              }
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.week,
                    calendarStyle: CalendarStyle(
                        todayColor: Colors.deepPurple[200],
                        selectedColor: Colors.deepPurple,
                        // ignore: prefer_const_constructors
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.black)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      // ignore: prefer_const_constructors
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    onDaySelected: (date, events, _) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
                      singleMarkerBuilder: (context, date, event) {
                        return Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color.fromRGBO(255, 255, 255, 1.0)),
                          width: 7.0,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        );
                      },
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              // color: Colors.deepPurple,
                              border: Border.all(
                                  width: 2.2, color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            date.day.toString(),
                            // ignore: prefer_const_constructors
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
                  ..._selectedEvents.map((event) => ListTile(
                        title: Text(event.title),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EventDetailsPage(
                                        event: event,
                                      )));
                        },
                      )),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'add_event'),
      ),
    );
  }
}
