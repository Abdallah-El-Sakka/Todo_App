// import 'package:sqflite/sqflite.dart';
//
// import '../Screens/new_tasks.dart';
//
// List<Map> tasks = [];
//
// class TasksData
// {
//   late Database db;
//
//   void createDatabase() async
//   {
//     db = await openDatabase(
//         'tasks2.db',
//         version: 1,
//         onCreate: (database,version) async
//         {
//           print('Database created');
//         },
//         onOpen: (database) async
//         {
//           print('Database opened');
//           getDataFromDatabase(database);
//         }
//     );
//   }
//
//   void insertToDatabase(String name) async
//   {
//     await db.transaction((txn) async
//     {
//       await txn.rawInsert('INSERT INTO Tasks(name) VALUES("$name")')
//           .then((value)
//       {
//         print('inserted $name with id $value');
//
//         getDataFromDatabase(db);
//
//       });
//     });
//   }
//
//   void getDataFromDatabase(database) async
//   {
//     tasks = await database.rawQuery('SELECT * FROM Tasks');
//     print(tasks);
//     NewTasksScreenState().updateUI();
//   }
//
//   void deleteFromDatabase(int id) async
//   {
//     await db.rawDelete(
//         'DELETE FROM Tasks WHERE id = ?',
//         [id]
//     );
//
//     getDataFromDatabase(db);
//
//   }
//
// }