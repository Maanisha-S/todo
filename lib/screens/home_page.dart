import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample_todo/core/todo_model.dart';
import 'package:sample_todo/widget/appbar_design.dart';
import 'package:sample_todo/widget/custom_textfield_design.dart';
import 'package:sample_todo/widget/edit_dialogbox_design.dart';
import 'package:sample_todo/widget/material_button_design.dart';
import 'package:sample_todo/widget/todo_list_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _taskNameController = TextEditingController();
  final _hoursController = TextEditingController();
  final _minutesController = TextEditingController();
  final _periodController = TextEditingController();
  final List<Todo> _todos = [];
  TimeOfDay? timeEstimation;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _taskFocusNode = FocusNode();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _taskNameController.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  void _addTodo() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final taskName = _taskNameController.text;
      final time = timeEstimation != null ? _formatTimeOfDay(timeEstimation!) : '';

      setState(() {
        _todos.add(Todo(
          name: name,
          taskName: taskName,
          timeEstimation: time,
        ));
      });
      _nameController.clear();
      _taskNameController.clear();
      _hoursController.clear();
      _minutesController.clear();
      setState(() {
        timeEstimation = null;
      });

      _controller.forward(from: 0);
    }
  }

  void _deleteTodos() {
    setState(() {
      _todos.clear();
    });
  }

  void _deleteTodoAt(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _editTodo(int index, Todo updatedTodo) {
    setState(() {
      _todos[index] = updatedTodo;
    });
  }

  void _showEditDialog(BuildContext context, int index, Todo todo) {
    showDialog(
      context: context,
      builder: (context) => EditTodoDialog(
        index: index,
        todo: todo,
        onEdit: _editTodo,
      ),
    );
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('hh:mm a').format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        action: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: _deleteTodos,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  CustomTextField(
                    focusNode: _nameFocusNode,
                    controller: _nameController,
                    labelText: 'Name',
                    prefixIcon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    focusNode: _taskFocusNode,
                    controller: _taskNameController,
                    labelText: 'Task Name',
                    prefixIcon: Icons.task,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () async {
                      _nameFocusNode.unfocus();
                      _taskFocusNode.unfocus();
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
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
                                initialTime: TimeOfDay.now(),
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
                            style: TextStyle(color:  timeEstimation != null ? Colors.black : Colors.purple,fontFamily: 'Poppins'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  MaterialButtonDesign(text:  'Add To-Do', width: 200,height: 20,onTap: _addTodo,),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return TodoListItem(
                  todo: todo,
                  animation: _animation,
                  onDelete: () {
                    _deleteTodoAt(index);
                  },
                  onEdit: _showEditDialog,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
