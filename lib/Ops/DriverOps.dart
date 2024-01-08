import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Driver/Profile.dart';

class DriverOps {
  static Future<String?> findDriverIdByEmail(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Drivers')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      return null;
    }
  }

  static Future<Driver?> getDriverDetails(String? id) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Drivers')
          .get();

      if (querySnapshot != null) {
        for (QueryDocumentSnapshot driverDoc in querySnapshot.docs) {
          if (driverDoc.id == id) {
            return Driver(
              name:driverDoc['fullname'],
              email:driverDoc['email'],
              phoneNumber:driverDoc['phoneNumber'],
            );
          }
        }
      }
      return null; // Return null if no matching driver ID is found
    } catch (e) {
      print('Error fetching driver details: $e');
      return null; // Handle any potential errors during the process
    }
  }


}
