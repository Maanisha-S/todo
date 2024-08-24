import 'package:flutter/material.dart';
import 'package:sample_todo/core/todo_model.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final Animation<double> animation;
  final VoidCallback onDelete;
  final Function(BuildContext, int, Todo) onEdit;

  const TodoListItem({
    super.key,
    required this.todo,
    required this.animation,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: Dismissible(
          key: Key(todo.taskName),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.purple,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              onDelete();
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(15),
            ),
            child:
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              title: Text(
                todo.taskName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                  fontSize: 22,
                    fontFamily: 'Poppins'
                ),
              ),
              subtitle: Text(
                '${todo.name} - ${todo.timeEstimation}',
                style: const TextStyle(color: Colors.black87, fontSize: 16,fontFamily: 'Poppins'),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.purple),
                    onPressed: () {
                      onEdit(context, 0, todo);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
