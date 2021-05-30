import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widgets/widgets.dart';

class CompletedTodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final provider1 = Provider.of<TodosProvider>(context, listen: false);
    provider1.getUserData();
    final todos = provider.completedTodos;
    return todos.isEmpty
        ? Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/completed.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "No Tasks",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/completed.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListView.separated(
                separatorBuilder: (context, index) => Container(
                  height: 32.0,
                ),
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.0),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return TodoWidget(todo: todo);
                },
              ),
            ],
          );
  }
}
