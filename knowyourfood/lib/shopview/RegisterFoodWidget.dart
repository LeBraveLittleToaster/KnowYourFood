import 'package:flutter/material.dart';
import 'package:knowyourfood/stores/Food.dart';
import 'package:knowyourfood/stores/FoodStore.dart';
import 'package:knowyourfood/stores/Preference.dart';
import 'package:knowyourfood/stores/PreferenceStore.dart';
import 'package:provider/provider.dart';

class RegisterFoodWidget extends StatefulWidget {
  List<Preference> prefs;

  RegisterFoodWidget(
    this.prefs,
  );

  @override
  State<StatefulWidget> createState() => _RegisterFoodState();
}

class RegisterFoodData {
  String prefId;
  int rating = -1;
  TextEditingController statementText;
  String prefName;

  RegisterFoodData({required this.prefId, required this.statementText, required this.prefName});

  PrefStatement getStatement() {
    return PrefStatement(
        prefId: prefId, rating: rating, statement: statementText.text, prefName: prefName);
  }

  bool isStatementComplete() {
    return rating != -1 && statementText.text.length > 0 && prefName.length > 0;
  }
}

class _RegisterFoodState extends State<RegisterFoodWidget> {
  late TextEditingController _brandNameController;
  late TextEditingController _foodNameController;
  late TextEditingController _descriptionNameController;

  List<bool> _isExpandedList = [];
  List<RegisterFoodData> _foodData = [];
  bool _isUploadLocked = false;

  @override
  void initState() {
    this._isExpandedList = List<bool>.filled(widget.prefs.length + 1, false);
    this._isExpandedList[0] = true;
    this._foodData = this
        .widget
        .prefs
        .map((e) => RegisterFoodData(
            prefId: e.prefId,
            statementText: TextEditingController(text: "Test Statement"),
            prefName: e.name))
        .toList();
    _foodNameController = TextEditingController(text: "Test Food name");
    _brandNameController = TextEditingController(text: "Test Brand Name");
    _descriptionNameController = TextEditingController(text: "Test Desc");
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new food"),
      ),
      body: Center(
        child: Consumer<PreferenceStore>(
          builder: (context, value, child) {
            return buildStatementList(value.prefs);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: this._isUploadLocked
            ? null
            : () async {
                _isUploadLocked = true;
                Future<String?>? resp = _uploadFood();
                if (resp == null) {
                  _isUploadLocked = false;
                } else {
                  resp
                      .then((value) => Navigator.pop(context))
                      .onError((error, stackTrace) => _isUploadLocked = false);
                }
              },
        child: Icon(Icons.upload_file_outlined),
      ),
    );
  }

  Future<String?>? _uploadFood() {
    List<PrefStatement> filledStatements = [];
    _foodData.forEach((e) {
      if (e.prefId.length > 0 && e.statementText.text.length > 0) {
        filledStatements.add(PrefStatement(
            prefId: e.prefId,
            rating: e.rating,
            statement: e.statementText.text,
            prefName: e.prefName));
      }
    });
    Food food = Food(
        brandName: _brandNameController.text,
        description: _descriptionNameController.text,
        foodId: "",
        name: _foodNameController.text,
        prefs: filledStatements);
    if (food.brandName.length > 0 &&
        food.description.length > 0 &&
        food.name.length > 0 &&
        food.prefs.length > 0) {
      return Provider.of<FoodStore>(context, listen: false).uploadNewFood(food);
    } else {
      print("FAILED to parse food!");
    }
    return null;
  }

  ExpansionPanel buildNamingExpansionPanel() {
    return ExpansionPanel(
        canTapOnHeader: true,
        isExpanded: _isExpandedList[0],
        headerBuilder: (context, isExpanded) {
          return Center(
              child: Text(
            "Name",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ));
        },
        body: buildStateName());
  }

  Widget buildStatementList(List<Preference> prefs) {
    List<ExpansionPanel> panels = prefs
        .asMap()
        .map((index, pref) => buildStatement(index + 1, pref))
        .values
        .toList();
    panels.insert(0, buildNamingExpansionPanel());
    return ListView(
      children: [
        ExpansionPanelList(
          elevation: 6,
          expansionCallback: (i, isOpen) {
            setState(() {
              this._isExpandedList[i] = !isOpen;
            });
          },
          children: panels,
        ),
      ],
    );
  }

  Color getColor(int rating) {
    switch (rating) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  MapEntry<int, ExpansionPanel> buildStatement(
      int index, Preference preference) {
    return MapEntry(
        index,
        ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Row(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                  child: IconTheme(
                      data: IconThemeData(
                          color: getColor(_foodData[index - 1].rating)),
                      child: Icon(Icons.circle)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
                  child: Text(preference.name),
                ),
              ]);
            },
            isExpanded: this._isExpandedList[index],
            canTapOnHeader: true,
            body: Center(child: buildStatementInputFields(index - 1))));
  }

  Widget buildStateName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _foodNameController,
            decoration: InputDecoration(
                isDense: true, border: OutlineInputBorder(), labelText: "Name"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _brandNameController,
            decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                labelText: "Brand Name"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _descriptionNameController,
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: null,
            decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
                labelText: "Description"),
          ),
        ),
      ],
    );
  }

  Widget buildStatementInputFields(int index) {
    return Column(children: [
      Text("Rating"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              color: Colors.red,
              onPressed: () => setState(() {
                    this._foodData[index].rating = 0;
                  }),
              icon: Icon(Icons.exposure_minus_1_rounded)),
          IconButton(
              color: Colors.yellow,
              onPressed: () => setState(() {
                    this._foodData[index].rating = 1;
                  }),
              icon: Icon(Icons.exposure_zero)),
          IconButton(
              color: Colors.green,
              onPressed: () => setState(() {
                    this._foodData[index].rating = 2;
                  }),
              icon: Icon(Icons.exposure_plus_1))
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: this._foodData[index].statementText,
          minLines: 3,
          maxLines: 20,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Statement"),
        ),
      ),
    ]);
  }
}
