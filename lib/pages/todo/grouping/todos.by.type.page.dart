// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:todo/openapi/lib/api.dart';
import 'package:todo/pages/todo/grouping/page.args.dart';

import '../../../util/todo.stats.dart';
import '../../../widgets/progress.todo.card.dart';
import '../../home/widgets/todo.dart';

class TodosByType extends StatefulWidget {
  static const String routeName = "/todosByType";

  const TodosByType({Key? key}) : super(key: key);

  @override
  State<TodosByType> createState() => _TodosByType();
}

class _TodosByType extends State<TodosByType> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments screenArgs =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final TodoStats todoStats = screenArgs.todoStats;
    final TodoDTOTodoTypeEnum todoType = screenArgs.todoType;
    final List<TodoDTO> todos = todoStats.getTodosByType(screenArgs.todoType);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              )),
          elevation: 0.2,
          backgroundColor: Colors.white,
          title: Text(
            screenArgs.todoType.toString(),
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Cerebri Sans",
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  Center(
                      child: ProgressTodoCard(todos: todos, completed: true)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Today'.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Bebas',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'You completed ${todoStats!.countCompletedTodosForTodayByType(todoType)} of ${todoStats!.countTodosForTodayByType(todoType)} todos.',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    height: 25,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'COMPLETED',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: todoStats
                                        .countCompletedTodosByType(
                                            screenArgs.todoType)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'IN PROGRESS',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: todoStats
                                        .countInProgressTodosByType(
                                            screenArgs.todoType)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 15,
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return TodoWidget(
                        todo: TodoDTO(
                            id: todos[index].id,
                            todoType: todos[index].todoType,
                            completed: todos[index].completed,
                            dueDate: todos[index].dueDate!,
                            description: todos[index].description,
                            createdDate: todos[index].createdDate,
                            deleted: todos[index].deleted));
                  }),
            ),
          ],
        ));
  }
}
