import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:currensee/models/conversion_history.dart';

class ConversionHistoryService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveConversionHistory(ConversionHistory history) async {
    User user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('conversion_history')
          .add(history.toMap());
    }
  }

  Future<List<ConversionHistory>> getConversionHistory() async {
    User user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('conversion_history')
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => ConversionHistory.fromMap(doc.data()))
          .toList();
    } else {
      return [];
    }
  }
}