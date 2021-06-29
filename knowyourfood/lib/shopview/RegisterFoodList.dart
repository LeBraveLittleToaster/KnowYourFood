import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:knowyourfood/stores/FoodStore.dart';
import 'package:knowyourfood/stores/Preference.dart';
import 'package:knowyourfood/stores/PreferenceStore.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'RegisterFoodWidget.dart';

class RegisterFoodList extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<FoodStore>(
          builder: (context, foodStore, child) {
            if (foodStore.isLoading)
              return SpinKitChasingDots(
                color: Colors.blueGrey,
              );
            return ListView.builder(
              itemCount: foodStore.food.length,
              itemBuilder: (context, foodIndex) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    tileColor: Color.fromRGBO(255, 255, 255, .2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => ListView.builder(
                        itemCount: foodStore.food[foodIndex].prefs.length,
                        itemBuilder: (context, prefIndex) => ListTile(
                          title: Text(
                            foodStore.food[foodIndex].prefs[prefIndex].prefName,
                            style: TextStyle(
                                color: getColor(foodStore
                                    .food[foodIndex].prefs[prefIndex].rating)),
                          ),
                          subtitle: Text(foodStore
                              .food[foodIndex].prefs[prefIndex].statement),
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        foodStore.food[foodIndex].name,
                        style: TextStyle(
                            color: Colors.yellow[700],
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 4, 16),
                      child: Text(foodStore.food[foodIndex].brandName,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w900)),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.qr_code_2,
                        color: Colors.yellow[700],
                      ),
                      onPressed: () => {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: QrImage(
                              data: foodStore.food[foodIndex].id,
                              version: QrVersions.auto,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              gapless: false,
                              size: MediaQuery.of(context).size.width * 1,
                            ),
                          ),
                        )
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              foregroundColor: Colors.yellow,
              backgroundColor: Colors.grey[850],
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Consumer<PreferenceStore>(
                            builder: (context, prefStore, child) =>
                                RegisterFoodWidget(prefStore.prefs))));
              },
              child: Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }
}
