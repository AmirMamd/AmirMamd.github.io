import 'package:carpool_driver/Service/AddRouteService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRouteOps{
  static Future<bool> checkIfRouteExists(String driverId, String enteredName) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot<Map<String, dynamic>> routesSnapshot = await firestore
          .collection('Drivers')
          .doc(driverId)
          .collection('VisitedLocations')
          .get();

      List<Map<String, dynamic>> routesData = routesSnapshot.docs.map((doc) => doc.data()).toList();
      return AddRouteService.doesRouteExist(routesData, enteredName);
    } catch (e) {
      print('Error checking route existence: $e');
      return false;
    }
  }


  static Future<void> addRoute(String driverId, String imageUrl, String name, String price) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('Drivers').doc(driverId).collection('VisitedLocations').add({
        'imageUrl': imageUrl,
        'name': name,
        'price': int.parse(price),
      });
    } catch (e) {
      print('Error adding route: $e');
    }
  }
}