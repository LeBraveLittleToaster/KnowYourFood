import 'package:flutter/material.dart';
import 'package:knowyourfood/stores/Preference.dart';

class RegisterFoodWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFoodState();
}

class _RegisterFoodState extends State<RegisterFoodWidget> {
  late TextEditingController _brandNameController;
  late TextEditingController _foodNameController;
  late TextEditingController _descriptionNameController;

  // 0 = names
  // 1 = choosing statements
  // 2 = making statement
  int state = 0;
  List<PrefStatement> statements = [];

  @override
  void initState() {
    super.initState();
    _foodNameController = TextEditingController();
    _brandNameController = TextEditingController();
    _descriptionNameController = TextEditingController();
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _brandNameController.dispose();
    _descriptionNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case 0:
        return buildStateName();
      case 1:
        return buildChooseStatements();
      case 2:
        return buildMakeStatements();
      default:
        return buildStateName();
    }
  }

  Widget buildChooseStatements(){
    return Container();
  }

  Widget buildMakeStatements(){
    return Container();
  }

  Widget buildStateName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _foodNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Name"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _brandNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Brand Name"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _descriptionNameController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Brand Name"),
          ),
        ),
      ],
    );
  }
}
