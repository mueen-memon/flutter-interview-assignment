import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/weight.dart';

class Weights with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addWeight(WeightData weightData) async {
    try {
      CollectionReference weights =
          FirebaseFirestore.instance.collection('weightData');

      final responce = await weights.add(
        {
          'weight': weightData.weight,
          'measureDate': weightData.measureDate,
        },
      );
      final newWeight = WeightData(
        id: responce.id,
        weight: weightData.weight,
        measureDate: weightData.measureDate,
      );

      notifyListeners();
    } catch (e) {
      print('error $e');
      rethrow;
    }
  }

  Future<void> updateWeight(String id, double newWeight) async {
    try {
      CollectionReference products =
          FirebaseFirestore.instance.collection('weightData');
      await products.doc(id).update({
        'measureDate': DateTime.now().toIso8601String(),
        'weight': newWeight,
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteWeight(String id) async {
    CollectionReference weights =
        FirebaseFirestore.instance.collection('weightData');

    weights
        .doc(id)
        .delete()
        .then(
          (value) => print("Product Deleted"),
        )
        .onError((error, stackTrace) {
      print('could not delete the product');
    });

    notifyListeners();
  }
}
