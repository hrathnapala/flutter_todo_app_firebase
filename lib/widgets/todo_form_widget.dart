import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget(
      {Key? key,
      this.title = '',
      this.description = '',
      required this.onChangedTitle,
      required this.onChangedDescription,
      required this.onSavedTodo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitle(),
          _buildDescription(),
          SizedBox(
            height: 20.0,
          ),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'The Topic cannot be empty';
          }
          return null;
        },
        decoration:
            InputDecoration(border: UnderlineInputBorder(), labelText: "Topic"),
      );
  Widget _buildDescription() => TextFormField(
        initialValue: description,
        onChanged: onChangedDescription,
        maxLines: 3,
        decoration:
            InputDecoration(border: UnderlineInputBorder(), labelText: "Tasks"),
      );
  Widget _buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onSavedTodo,
          child: Text("Save"),
        ),
      );
}
