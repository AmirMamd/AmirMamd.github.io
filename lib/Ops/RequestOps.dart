import 'dart:async';

import 'package:carpool_driver/Ops/DriverOps.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestOps {
  static Stream<List<Map<String, dynamic>>> getAllRequestsStream(String? currentDriverId) {
    final StreamController<List<Map<String, dynamic>>> controller =
    StreamController<List<Map<String, dynamic>>>.broadcast();

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Listen for changes on the 'Requests' collection
    firestore.collection('Requests').snapshots().listen((requestsSnapshot) async {
      List<Map<String, dynamic>> result = [];
      QuerySnapshot driversSnapshot = await firestore.collection('Drivers').get();
      Map<String, Map<String, dynamic>> userData = {};

      QuerySnapshot userSnapshot = await firestore.collection('Users').get();
      for (final doc in userSnapshot.docs) {
        userData[doc.id] = {
          'fullName': doc['fullName'],
          'email': doc['email'],
          'phoneNumber': doc['phoneNumber'],
        };
      }

      for (QueryDocumentSnapshot requestDoc in requestsSnapshot.docs) {
        String userId = requestDoc['userId'];
        String visitedLocationId = requestDoc['visitedLocationId'];
        String status = requestDoc['status'];
        String driverId = requestDoc['driverId'];
        DateTime date = (requestDoc['date'] as Timestamp).toDate();
        String requestId = requestDoc.id;
        String meetingPoint = requestDoc['meetingPoint'];

        if (driverId == currentDriverId) {
          Map<String, dynamic>? user = userData[userId];

          String fullName = user?['fullName'] ?? '';
          String email = user?['email'] ?? '';
          int phoneNumber = user?['phoneNumber'] ?? 0;

          String imageUrl = '';
          String name = '';
          double price = 0.0;

          for (QueryDocumentSnapshot driverDoc in driversSnapshot.docs) {
            QuerySnapshot visitedLocationsSnapshot = await driverDoc.reference
                .collection('VisitedLocations')
                .where(FieldPath.documentId, isEqualTo: visitedLocationId)
                .get();

            if (visitedLocationsSnapshot.docs.isNotEmpty) {
              imageUrl = visitedLocationsSnapshot.docs.first['imageUrl'];
              name = visitedLocationsSnapshot.docs.first['name'];
              price = visitedLocationsSnapshot.docs.first['price'].toDouble();
              break;
            }
          }

          result.add({
            'userId': userId,
            'status': status,
            'date': date,
            'visitedLocationId': visitedLocationId,
            'imageUrl': imageUrl,
            'name': name,
            'price': price,
            'fullName': fullName,
            'email': email,
            'phoneNumber': phoneNumber,
            'Id' : requestId,
            'meetingPoint' : meetingPoint
          });
        }
      }

      // Add the list to the stream
      controller.add(result);
    });

    return controller.stream;
  }

  static Future<void> updateRequestStatus(String requestId, String newStatus) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Update the status of the request using the provided request ID
      await firestore.collection('Requests').doc(requestId).update({
        'status': newStatus,
      });
    } catch (e) {
      print('Error updating status: $e');
      throw e; // Propagate the error if needed
    }
  }
}
