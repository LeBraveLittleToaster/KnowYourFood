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
            color: Colors.accents[0],
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
                child: ListTile(
                  trailing: ratingColor == null
                      ? null
                      : IconTheme(
                          data: IconThemeData(color: ratingColor),
                          child: Icon(Icons.circle)),
                  title: Text(prefStore.prefs[index].name),
                  subtitle: Text(prefStore.prefs[index].description),
                ),
              ),
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Low',
                  color: Colors.red,
                  icon: Icons.arrow_downward,
                  onTap: () => {
                    prefStore.addOrUpdateRating(1, prefStore.prefs[index].prefId)
                  },
                ),
                IconSlideAction(
                  caption: 'Medium',
                  color: Colors.orange,
                  icon: Icons.remove,
                  onTap: () => {
                    prefStore.addOrUpdateRating(2, prefStore.prefs[index].prefId)
                  },
                ),
                IconSlideAction(
                  caption: 'High',
                  color: Colors.green,
                  icon: Icons.arrow_upward,
                  onTap: () => {
                    prefStore.addOrUpdateRating(3, prefStore.prefs[index].prefId)
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
