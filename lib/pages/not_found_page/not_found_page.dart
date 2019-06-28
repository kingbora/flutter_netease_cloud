import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("404Page"),
      ),
      body: Center(
        child: Text("404 Page Not Found!"),
      ),
    );
  }
}
