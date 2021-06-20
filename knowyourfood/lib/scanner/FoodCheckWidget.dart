import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:knowyourfood/stores/Food.dart';
import 'package:knowyourfood/stores/Preference.dart';
import 'package:knowyourfood/stores/PreferenceStore.dart';
import 'package:provider/provider.dart';

class FoodCheckWidget extends StatefulWidget {
  Food? food;

  FoodCheckWidget({required this.food});

  @override
  State<StatefulWidget> createState() => _FoodCheckState();
}

class _FoodCheckState extends State<FoodCheckWidget> {
  bool _isLoading = true;
  List<Preference> prefs = [];

  _loadPrefs() async {
    Provider.of<PreferenceStore>(context,listen: false)
        .getFilteredPreferences(
            widget.food!.prefs.map((e) => e.prefId).toList())
        .then((value) => setState(() {
              this.prefs = value;
            }))
        .whenComplete(() => setState(() {
              _isLoading = false;
            }));
  }

  @override
  void initState(){
    super.initState();
    if(widget.food != null) _loadPrefs();
  }

  @override
  void didUpdateWidget(oldWidget){
    super.didUpdateWidget(oldWidget);
    if(widget.food != null) _loadPrefs();
    print("UPDATING");
  }

  @override
  Widget build(BuildContext context) {
    PreferenceStore prefStore = Provider.of<PreferenceStore>(context);
    if (_isLoading) {
      return Center(
        child: SpinKitChasingDots(
          color: Colors.red,
        ),
      );
    }
    return widget.food == null
        ? Center(
            child: Text("Please Scan QR code"),
          )
        : ListView.builder(
            itemCount: widget.food!.prefs.length,
            itemBuilder: (context, index) {
              PrefRating? rating = null;
              Preference? preference = null;
              try {
                preference = this.prefs.firstWhere(
                    (element) => element.prefId == widget.food!.prefs[index]);
                rating = prefStore.userRatings.firstWhere(
                    (element) => element.prefId == widget.food!.prefs[index]);
              } catch (error) {
                print("No rating hehe");
              }
              return ListTile(
                title: Text(preference == null
                    ? "No preference name found"
                    : preference.name),
                subtitle: Text(widget.food!.prefs[index].statement),
              );
            },
          );
  }
}
