import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'blocStates.dart';

List<Map> tasks = [];
List<Map> newTasks = [];
List<Map> doneTasks = [];
List<Map> archivedTasks = [];

late Database db;

class ToDoCubit extends Cubit<ToDoStates>
{
  ToDoCubit() : super(InitialState());

  static ToDoCubit get(context) => BlocProvider.of(context);


  void createDatabase() async
  {

    db = await openDatabase(
        'tasks3.db',
        version: 1,
        onCreate: (database,version) async
        {

          database.execute('CREATE TABLE Tasks (id INTEGER PRIMARY KEY, name TEXT, state TEXT)');

          print('Database created');
        },
        onOpen: (database) async
        {
          print('Database opened');
          getDataFromDatabase(database);
        }
    );
  }

  void getDataFromDatabase(database) async
  {

    newTasks.clear();
    doneTasks.clear();
    archivedTasks.clear();

    tasks = await database.rawQuery('SELECT * FROM Tasks');

    tasks.forEach((element)
    {
      if(element['state'] == 'archived')
      {
        archivedTasks.add(element);
      }
      else if(element['state'] == 'done')
      {
        doneTasks.add(element);
      }
      else
      {
        newTasks.add(element);
      }
    });

    print(tasks);
    emit(GetDataState());
  }


  void insertToDatabase(String name) async
  {
    await db.transaction((txn) async
    {
      await txn.rawInsert('INSERT INTO Tasks(name, state) VALUES("$name" , "new")')
          .then((value)
      {
        emit(InsertToDatabase());
        print('inserted $name with id $value');
        getDataFromDatabase(db);

      });
    });
  }



  void deleteFromDatabase(int id) async
  {
    await db.rawDelete(
        'DELETE FROM Tasks WHERE id = ?',
        [id]
    );

    getDataFromDatabase(db);

  }

  void changeDataState(int id, String state) async
  {
    await db.rawUpdate(
        'UPDATE Tasks SET state = ? WHERE id = ?',
        [state , id]
    );
    getDataFromDatabase(db);

  }


}