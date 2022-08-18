import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Database/blocClass.dart';
import '../Database/blocStates.dart';
import 'Nav_bar.dart';

class ArchivedTasksScreen extends StatefulWidget
{
  @override
  State<ArchivedTasksScreen> createState() => _ArchivedTasksScreenState();
}

class _ArchivedTasksScreenState extends State<ArchivedTasksScreen>
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ToDoCubit,ToDoStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return archivedTasks.isEmpty ? Center(
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
                  'No Archived Tasks Yet.',
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
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: archivedTasks.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction)
                      {
                        ToDoCubit.get(context).deleteFromDatabase(archivedTasks[index]['id']);
                      },
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children:
                          [
                            Expanded(
                              child: Text(
                                archivedTasks[index]['name'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: ()
                                {
                                  ToDoCubit.get(context).changeDataState(archivedTasks[index]['id'], 'done');
                                },
                                icon: Icon(Icons.done)
                            )

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
