import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:knowyourfood/stores/Preference.dart';
import 'package:knowyourfood/stores/PreferenceStore.dart';
import 'package:provider/provider.dart';

class PrefPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrefPageState();
}

class _PrefPageState extends State<PrefPageWidget> {
  @override
  Widget build(BuildContext context) {
    PreferenceStore prefStore = Provider.of<PreferenceStore>(context);
    return Consumer<PreferenceStore>(builder: (context, prefStore, child) {
      if (prefStore.isLoading) {
        return Center(
          child: SpinKitChasingDots(
            color: Colors.yellow[700],
          ),
        );
      } else {
        return ListView.builder(
          itemCount: prefStore.prefs.length,
          itemBuilder: (context, index) {
            Color? ratingColor = null;
            try {
              PrefRating rating = prefStore.userRatings.firstWhere(
                  (element) => element.prefId == prefStore.prefs[index].prefId);
              switch (rating.rating) {
                case 1:
                  ratingColor = Colors.red;
                  break;
                case 2:
                  ratingColor = Colors.yellow;
                  break;
                case 3:
                  ratingColor = Colors.green;
                  break;
              }
            } catch (error) {
              print("No rating yet");
            }

            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    tileColor: Color.fromRGBO(255, 255, 255, .2),
                    trailing: ratingColor == null
                        ? null
                        : IconTheme(
                            data: IconThemeData(color: ratingColor),
                            child: Icon(Icons.circle)),
                    title: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        prefStore.prefs[index].name,
                        style: TextStyle(
                            color: Colors.yellow[700],
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 4, 16),
                      child: Text(
                        prefStore.prefs[index].description,
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 16,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Low',
                  color: Colors.red,
                  icon: Icons.arrow_downward,
                  onTap: () => {
                    prefStore.addOrUpdateRating(
                        1, prefStore.prefs[index].prefId)
                  },
                ),
                IconSlideAction(
                  caption: 'Medium',
                  color: Colors.orange,
                  icon: Icons.remove,
                  onTap: () => {
                    prefStore.addOrUpdateRating(
                        2, prefStore.prefs[index].prefId)
                  },
                ),
                IconSlideAction(
                  caption: 'High',
                  color: Colors.green,
                  icon: Icons.arrow_upward,
                  onTap: () => {
                    prefStore.addOrUpdateRating(
                        3, prefStore.prefs[index].prefId)
                  },
                )
              ],
            );
          },
        );
      }
    });
  }
}
