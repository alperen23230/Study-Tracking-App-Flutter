import 'package:StudyTrackingApp/screens/lessons_screen/lessons_screen.dart';
import 'package:StudyTrackingApp/screens/lessons_screen/lessons_screen_view.dart';
import 'package:StudyTrackingApp/screens/statistics_screen/statistics_screen.dart';
import 'package:StudyTrackingApp/screens/study_input_screen/study_input_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [
    {
      'page': StudyInputScreen(),
      'title': 'Öğrenci Çalışmaları',
      'appBarAction': studyInputScreenAppBarAction
    },
    {
      'page': LessonsScreen(),
      'title': 'Dersler',
      'appBarAction': lessonsScreenAppBarAction,
    },
    {
      'page': StatisticsScreen(),
      'title': 'İstatistikler',
      'appBarAction': statisticsScreenAppBarAction,
    }
  ];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  static Widget lessonsScreenAppBarAction(BuildContext ctx) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {},
    );
  }

  static Widget get studyInputScreenAppBarAction {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        print("add input");
      },
    );
  }

  static Widget get statisticsScreenAppBarAction {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        actions: <Widget>[
          Visibility(
            visible: _pages[_selectedPageIndex]['title'] != "İstatistikler",
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                if (_pages[_selectedPageIndex]['title'] == "Dersler") {
                  Navigator.of(context).pushNamed('/add-lesson');
                } else if (_pages[_selectedPageIndex]['title'] ==
                    "Öğrenci Çalışmaları") {
                  //Navigate another screeen
                }
              },
            ),
          ),
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Çalışmalar"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text("Dersler"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: Text("İstatistikler"),
          ),
        ],
      ),
    );
  }
}
