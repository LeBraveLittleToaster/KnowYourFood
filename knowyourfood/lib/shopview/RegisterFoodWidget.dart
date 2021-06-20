import 'package:flutter/material.dart';

class RegisterFoodWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFoodState();
}

class _RegisterFoodState extends State<RegisterFoodWidget> {
  late TextEditingController _brandNameController;
  late TextEditingController _foodNameController;
  late TextEditingController _descriptionNameController;

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
    return Center(
      child: Column(
        children: [
          TextField(
            controller: _foodNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Name"),
          ),
          TextField(
            controller: _brandNameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Brand Name"),
          ),
          TextFormField(
            controller: _descriptionNameController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            expands: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Brand Name"),
          ),
        ],
      ),
    );
  }
}
