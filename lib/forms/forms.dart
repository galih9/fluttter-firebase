import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/forms/base_form.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({Key? key, required this.typeForm}) : super(key: key);

  final String typeForm;

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  late final String selectedText;
  late final String selectedForm;
  late final String selectedActionText;
  late final String selectedHint;

  @override
  void initState() {
    super.initState();
    if (widget.typeForm == "add") {
      selectedForm = "single";
      selectedText = "Add Task";
      selectedActionText = "Save";
      selectedHint = "Enter your task name";
    } else if (widget.typeForm == "edit") {
      selectedForm = "single";
      selectedText = "Update Task";
      selectedActionText = "Edit";
      selectedHint = "";
    } else if (widget.typeForm == "search") {
      selectedForm = "search";
      selectedText = "Search Task";
      selectedActionText = "";
      selectedHint = "Search here";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomFormView(
      titleForm: selectedText,
      typeForm: selectedForm,
      actionText: selectedActionText,
    );
  }
}
