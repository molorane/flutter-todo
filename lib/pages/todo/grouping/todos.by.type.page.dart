// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/openapi/lib/api.dart';

import '../../../dataprovider/todos.by.type.provider.dart';
import '../../../widgets/progress.todo.card.dart';
import '../../errors/error.dialog.dart';
import '../../errors/error.object.dart';
import '../../home/widgets/todo.dart';

class TodosByType extends ConsumerWidget {
  static const String routeName = "/todosByType";

  int countCompletedTodos(List<TodoGroupCount> todosCount) {
    final List<TodoGroupCount> countCompletedTodos =
        todosCount.where((element) => element.isCompleted).toList();

    return safeReduce(countCompletedTodos.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int countInProgressTodos(List<TodoGroupCount> todosCount) {
    final List<TodoGroupCount> countCompletedTodos =
        todosCount.where((element) => !element.isCompleted).toList();

    return safeReduce(countCompletedTodos.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int countCompletedTodosToday(List<TodoCountToday> todoCountToday) {
    final List<TodoCountToday> countCompletedTodosToday =
        todoCountToday.where((element) => element.isCompleted).toList();

    return safeReduce(
        countCompletedTodosToday.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int countTodosForToday(List<TodoCountToday> todoCountToday) {
    return safeReduce(todoCountToday.map((e) => e.totalTodos).toList(),
        (value, element) => value + element);
  }

  int safeReduce(List<int> list, Function function) {
    if (list.isEmpty) return 0;
    return list.reduce((v, e) => function(v, e));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TodoType todoType =
        ModalRoute.of(context)!.settings.arguments as TodoType;

    final todosByTypeStateData = ref.watch(todosByTypeStateProvider);

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
            todoType.toString(),
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Cerebri Sans",
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: todosByTypeStateData.when(
            loading: () => Center(child: CircularProgressIndicator()),
            data: (data) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ProgressTodoCard(
                                todos: data.todos, isCompleted: true)
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'TODAY',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'Bebas',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'You completed ${countCompletedTodosToday(data.todoCountToday)} of 0 todos.',
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
                                          text: countCompletedTodos(
                                                  data.todoGroupCount)
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                          text: countInProgressTodos(
                                                  data.todoGroupCount)
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            color:
                                                Theme.of(context).primaryColor,
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
                        itemCount: data.todos.length,
                        itemBuilder: (context, index) {
                          return TodoWidget(
                              todo: TodoDTO(
                                  id: data.todos[index].id,
                                  todoType: data.todos[index].todoType,
                                  isCompleted: data.todos[index].isCompleted,
                                  dueDate: data.todos[index].dueDate!,
                                  description: data.todos[index].description,
                                  createdDate: data.todos[index].createdDate,
                                  isDeleted: data.todos[index].isDeleted));
                        }),
                  ),
                ],
              );
            },
            error: (err, s) => ErrorDialog(
                errorObject: ErrorObject.mapErrorToObject(error: err))));
  }
}
