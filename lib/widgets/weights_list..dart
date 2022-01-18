import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/weight.dart';
import 'weight_item.dart';

class WeightsList extends StatelessWidget {
  const WeightsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('weightData')
          .orderBy('measureDate', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Text("An error has occured.");
        }
        if (!snapshot.hasData) {
          return const Text('no data availiable');
        } else {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data?.size,
              itemBuilder: (context, index) {
                final loadedWeight = WeightData(
                    id: snapshot.data!.docs[index].id,
                    measureDate: snapshot.data!.docs[index].get('measureDate'),
                    weight: snapshot.data!.docs[index].get('weight'));

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: WeightItem(weightData: loadedWeight),
                );
              });
        }
      },
    );
  }
}
