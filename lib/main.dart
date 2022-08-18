import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Layout/ToDoApp/Database/bloc_observer.dart';
import 'Layout/ToDoApp/Screens/Nav_bar.dart';

void main()
{
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.red,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.red,
            statusBarIconBrightness: Brightness.light
          ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
          )
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0.0,
          backgroundColor: Colors.red
        )
      ),
      home: NavBar(),
    );
  }
}
