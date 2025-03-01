


import 'package:flutter/material.dart';

class Web_view_from_app extends StatefulWidget {
  const Web_view_from_app({super.key});

  @override
  State<Web_view_from_app> createState() => _Web_view_from_appState();
}

class _Web_view_from_appState extends State<Web_view_from_app> {
  @override
  Widget build(BuildContext context) {
    return  PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Back"),
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
        ),
      ),
    );
  }
}
