import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/api/firebase_api.dart';
import 'package:todo_app/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
  List<Todo> get completedTodos =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
    return todo.isDone;
  }

  void removeTodo(Todo todo) => FirebaseApi.deleteTodo(todo);

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    FirebaseApi.updateTodo(todo);
  }

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  Future<void> getUserData() async {
    List<Todo> newList = [];
    Todo todo;
    QuerySnapshot todoSnapShot =
        await FirebaseFirestore.instance.collection("todo").get();
    todoSnapShot.docs.forEach(
      (element) {
        // final value = element.data();
        todo = Todo(
          createdTime: DateTime.now(),
          title: element["title"],
          id: element["id"],
          description: element["description"],
          isDone: element["isDone"],
        );
        newList.add(todo);
      },
    );

    _todos = newList;
    notifyListeners();
  }
}
