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
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.food != null) _loadPrefs();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.food != null) _loadPrefs();
    print("UPDATING");
  }

  @override
  Widget build(BuildContext context) {
    PreferenceStore prefStore = Provider.of<PreferenceStore>(context);
    if (_isLoading) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitChasingDots(
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Scan QRCode..."),
            ),
          ],
        ),
      );
    }
    return widget.food == null
        ? Center(
            child: Text("Please Scan QR code"),
          )
        : ListView.builder(
            itemCount: widget.food!.prefs.length,
            itemBuilder: (context, index) =>
                getListItem(widget.food!.prefs[index], prefStore, context),
          );
  }

  ListTile getListItem(PrefStatement prefStatement, PreferenceStore prefStore,
      BuildContext context) {
    PrefRating? rating;
    try {
      rating = prefStore.userRatings
          .firstWhere((r) => r.prefId == prefStatement.prefId);
    } catch (error, stacktrace) {
      print("No rating found for prefName=" + prefStatement.prefName + " ...");
    }

    return ListTile(
        title: Text(prefStatement.prefName),
        onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
                    child: Text(
                      "Statement",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
                    child: Text(
                      prefStatement.prefName,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 24, 12, 48),
                    child: Text(prefStatement.statement),
                  ),
                ],
              ),
            ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            generateComparisonIcon(prefStatement, rating ?? null)
          ],
        ));
  }

  Icon generateComparisonIcon(PrefStatement statement, PrefRating? rating) {
    if(statement.rating == -1) return Icon(Icons.check_box_outline_blank_outlined, color: Colors.grey,);
    if( rating == null) return Icon(Icons.check_box_outlined, color: Colors.grey,);
    if(statement.rating == rating.rating || statement.rating > rating.rating){
      return Icon(Icons.check_box_outlined, color: Colors.green);
    }else {
      return Icon(Icons.check_box_outline_blank_outlined, color: Colors.red);
    }
  }

  Color getColor(int rating) {
    switch (rating) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
