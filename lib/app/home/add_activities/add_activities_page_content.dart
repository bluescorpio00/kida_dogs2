import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddActivitiesPageContent extends StatefulWidget {
  const AddActivitiesPageContent({
    super.key,
  });

  @override
  State<AddActivitiesPageContent> createState() =>
      _AddActivitiesPageContentState();
}

class _AddActivitiesPageContentState extends State<AddActivitiesPageContent> {
  var activityName = '';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(hintText: 'Nazwa aktywności'),
            onChanged: (newValue) {
              setState(() {
                activityName = newValue;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Activities')
                    .add({'name': activityName, 'number': 4});
              },
              child: const Text('Dodaj')),
        ],
      ),
    );
  }
}
