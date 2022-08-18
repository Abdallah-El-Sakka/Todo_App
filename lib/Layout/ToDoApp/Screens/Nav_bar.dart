import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../Database/blocClass.dart';
import '../Database/blocStates.dart';
import 'archived_tasks.dart';
import 'done_tasks.dart';
import 'new_tasks.dart';


class NavBar extends StatefulWidget
{

  @override
  State<NavBar> createState() => _NavBarState();
}

int navIndex = 0;

List<String> navTitle =
    [
      'New Tasks',
      'Done Tasks',
      'Archived Tasks'
    ];

List<Widget> screens =
    [
      NewTasksScreen(),
      DoneTasksScreen(),
      ArchivedTasksScreen()
    ];

class _NavBarState extends State<NavBar>
{

  var scaffoldKey = GlobalKey<ScaffoldState>();

  var newTaskController = TextEditingController();

  bool isBottomSheetShown = false;

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context) => ToDoCubit()..createDatabase(),
      child: BlocConsumer<ToDoCubit, ToDoStates>(
        listener: (context , state) {},
        builder: (context,state)
        {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              titleSpacing: 20,
              title: Text(navTitle[navIndex]),
            ),
            body: screens[navIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: navIndex,
              onTap: (index)
              {
                navIndex = index;
                setState(() {});
              },
              items:
              const
              [
                BottomNavigationBarItem(
                    icon: Icon(Icons.access_alarm),
                    label: 'Tasks'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.task_alt_rounded),
                    label: 'Done'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived'
                ),
              ],

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {

                if(isBottomSheetShown)
                {

                  String data = newTaskController.text;
                  if(data.isNotEmpty)
                  {
                    ToDoCubit.get(context).insertToDatabase(data);
                    newTaskController.text = '';
                  }

                  Navigator.pop(context);

                  isBottomSheetShown = false;

                }
                else
                {
                  scaffoldKey.currentState?.showBottomSheet((context) => Container(
                    margin: EdgeInsetsDirectional.all(20),
                    child: TextFormField(
                      controller: newTaskController,
                      decoration: InputDecoration(
                          label: Text('Task'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),
                  ));

                  isBottomSheetShown = true;
                }

              },
              child: Icon(Icons.add),
            ),
          );
        },
      )
    );
  }
}
