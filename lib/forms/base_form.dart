import 'package:flutter/material.dart';

class CustomFormView extends StatefulWidget {
  const CustomFormView(
      {Key? key, required this.typeForm, required this.titleForm})
      : super(key: key);

  final String typeForm;
  final String titleForm;
  @override
  _CustomFormViewState createState() => _CustomFormViewState();
}

class _CustomFormViewState extends State<CustomFormView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleForm),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        child: null,
      ),
    );
  }
}
