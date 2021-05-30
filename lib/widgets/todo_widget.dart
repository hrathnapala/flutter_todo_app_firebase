import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/screens/screens.dart';
import 'package:todo_app/utils/util.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            key: Key(todo.id),
            actions: [
              IconSlideAction(
                color: Colors.black,
                onTap: () => editTodo(context, todo),
                caption: 'Edit',
                iconWidget: Icon(
                  Icons.edit,
                  color: Colors.amber,
                ),
              )
            ],
            secondaryActions: [
              IconSlideAction(
                color: Colors.black,
                onTap: () => deleteTodo(context, todo),
                caption: 'Delete',
                iconWidget: Icon(
                  Icons.remove_circle,
                  color: Colors.amber,
                ),
              )
            ],
            child: _buildTodo(context)),
      );

  Widget _buildTodo(BuildContext context) => Container(
        color: Colors.black,
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);
                Utils.showSnakBar(context,
                    isDone ? 'Task Completed' : 'Task Mark Incomplete');
              },
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white),
                ),
                if (todo.description.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 4.0),
                    child: Text(
                      todo.description,
                      style: TextStyle(
                          fontSize: 18.0, height: 1.2, color: Colors.white),
                    ),
                  )
              ],
            ))
          ],
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);

    provider.removeTodo(todo);

    Utils.showSnakBar(context, 'Deleted the Task');
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditTodoPage(todo: todo)));
  }
}
