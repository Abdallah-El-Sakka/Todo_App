import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Database/blocClass.dart';
import '../Database/blocStates.dart';

class NewTasksScreen extends StatefulWidget
{

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen>
{

  bool isBottomSheetVisible = false;

  @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener: (context, state) {},
      builder: (context , state)
      {

        return newTasks.isEmpty ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                    Icons.access_time_outlined,
                  size: 80,
                  color: Colors.black.withOpacity(0.2),
                ),
                SizedBox(height: 10,),
                Text(
                  'No tasks for you today.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.2)
                  ),
                )
              ],
            )
        ) : Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
              [
                Container(
                  margin: EdgeInsetsDirectional.all(15),
                  child: Container(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newTasks.length,
                      itemBuilder: (context, index) => Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction)
                        {
                          ToDoCubit.get(context).deleteFromDatabase(newTasks[index]['id']);
                        },
                        child: Row(
                          children:
                          [
                            Expanded(
                              child: Container(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  newTasks[index]['name'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.topEnd,
                              child: IconButton(
                                onPressed: ()
                                {
                                  ToDoCubit.get(context).changeDataState(newTasks[index]['id'] , 'done');
                                },
                                icon: Icon(Icons.done),
                                color: Colors.green,
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional.topEnd,
                              child: IconButton(
                                onPressed: ()
                                {
                                  ToDoCubit.get(context).changeDataState(newTasks[index]['id'], 'archived');
                                },
                                icon: Icon(Icons.archive_rounded),
                                color: Colors.grey,
                              ),
                            ),
                          ],

                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }





}
