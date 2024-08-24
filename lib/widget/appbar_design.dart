import 'package:flutter/material.dart';

class AppBarDesign extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? action;
  const AppBarDesign({super.key, this.action,});

  @override
  Widget build(BuildContext context) {
    return
      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
        title: const Text(
          'To-Do App',
          style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins"),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
           // color: Colors.teal,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Colors.purple,Colors.pink],
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30.0),
            ),
          ),
        ),
          actions: action
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
