import 'package:flutter/material.dart';
import 'package:sample_todo/core/todo_model.dart';
import 'package:sample_todo/widget/custom_textfield_design.dart';
import 'package:sample_todo/widget/material_button_design.dart';
import 'package:intl/intl.dart';

class EditTodoDialog extends StatefulWidget {
  final int index;
  final Todo todo;
  final Function(int, Todo) onEdit;

  const EditTodoDialog({
    super.key,
    required this.index,
    required this.todo,
    required this.onEdit,
  });

  @override
  _EditTodoDialogState createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  final _editFormKey = GlobalKey<FormState>();
  late TextEditingController _editNameController;
  late TextEditingController _editTaskNameController;
  TimeOfDay? timeEstimation;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _taskFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _editNameController = TextEditingController(text: widget.todo.name);
    _editTaskNameController = TextEditingController(text: widget.todo.taskName);
    final editTimeParts = widget.todo.timeEstimation.split(' ');
    final editHoursAndMinutes = editTimeParts[0].split(':');
    timeEstimation = TimeOfDay(
      hour: int.parse(editHoursAndMinutes[0]),
      minute: int.parse(editHoursAndMinutes[1]),
    );
  }

  @override
  void dispose() {
    _editNameController.dispose();
    _editTaskNameController.dispose();
    super.dispose();
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit To-Do',style: TextStyle(fontFamily: 'Poppins'),),
      content: SingleChildScrollView(
        child: Form(
          key: _editFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                focusNode: _nameFocusNode,
                controller: _editNameController,
                labelText: 'Name',
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                focusNode: _taskFocusNode,
                controller: _editTaskNameController,
                labelText: 'Task Name',
                prefixIcon: Icons.task,
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () async {
                  _nameFocusNode.unfocus();
                  _taskFocusNode.unfocus();
                  final time = await showTimePicker(
                    context: context,
                    initialTime: timeEstimation ?? TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      timeEstimation = time;
                    });
                  }
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    border: Border.all(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.access_time, color: Colors.purple),
                        onPressed: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: timeEstimation ?? TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              timeEstimation = time;
                            });
                          }
                        },
                      ),
                      Text(
                        timeEstimation != null ? _formatTimeOfDay(timeEstimation!) : 'Time Estimation',
                        style: TextStyle(color: timeEstimation != null ? Colors.black : Colors.purple),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        MaterialButtonDesign(text:  'Save', width: 100,height: 20,onTap: (){
          if (_editFormKey.currentState!.validate()) {
            final updatedTodo = Todo(
              name: _editNameController.text,
              taskName: _editTaskNameController.text,
              timeEstimation: timeEstimation != null ? _formatTimeOfDay(timeEstimation!) : '',
            );
            widget.onEdit(widget.index, updatedTodo);
            Navigator.of(context).pop();
          }
        }),
        MaterialButtonDesign(text:  'Cancel', width: 100,height: 20,onTap: (){
          Navigator.of(context).pop();
        }),

      ],
    );
  }
}
