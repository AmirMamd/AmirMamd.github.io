import 'package:carpool_driver/Driver/Routes/AddRoute.dart';
import 'package:carpool_driver/Ops/RequestOps.dart';
import 'package:carpool_driver/Service/RequestService.dart';
import 'package:carpool_driver/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Driver/Profile.dart';


class CustomItem {
  final String imageUrl;
  final String name;
  final double price;
  final DateTime dateTime;
  String status;
  final int number;
  final String fullName;

  CustomItem(
      this.imageUrl, this.name, this.price, this.dateTime, this.status, this.number, this.fullName);
}

class Requests extends StatefulWidget {
  final String? currentDriverId;
  Requests({required this.currentDriverId});
  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  late QuerySnapshot requestsSnapshot;
  String query = '';
  DateTime targetTime530 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 5, 30);
  DateTime targetTime730 = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 7, 30);
  bool verified = false;

  void filterItems(String newQuery) {
    setState(() {
      query = newQuery; // Update the query directly
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tileHeight = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Requests',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(width: screenWidth*0.7),
            IconButton(
              icon: Icon(Icons.person, color: Colors.white, size: 27),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(Id:widget.currentDriverId),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white, size: 27),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRoutePage(driverId: widget.currentDriverId),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white, size: 27),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(),
                  ),
                );
              },
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: TextField(
              onChanged: (query) {
                filterItems(query);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: RequestOps.getAllRequestsStream(widget.currentDriverId),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available.'));
              } else {
                List<Map<String, dynamic>> snapshots = snapshot.data!;

                // Apply search filter directly using the query
                List<Map<String, dynamic>> filteredSnapshots = query.isEmpty
                    ? snapshots // Show all items if query is empty
                    : snapshots.where((snapshot) =>
                    snapshot['name']
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredSnapshots.length,
                    itemBuilder: (BuildContext context, int index) {
                      var document = filteredSnapshots[index];
                      String Id = document['Id'] ?? '';
                      String imageUrl = document['imageUrl'] ?? '';
                      String name = document['name'] ?? '';
                      double price = document['price']?.toDouble() ?? 0.0;
                      String fullName = document['fullName'] ?? '';
                      String email = document['email'] ?? '';
                      int phoneNumber = document['phoneNumber'] ?? 0;
                      String status = document['status'] ?? '';
                      DateTime dateTime = document['date'];
                      String meetingPoint = document['meetingPoint'];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.pink,
                            width: 0.8,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          title: Row(
                            children: [
                              imageUrl.startsWith('assets') ?
                              Image.asset(
                                imageUrl,
                                height: tileHeight * 0.8,
                                width: screenWidth * 0.3,
                              ) : Image.network(
                                imageUrl,
                                height: tileHeight * 0.8,
                                width: screenWidth * 0.3,
                              ),
                              SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Price: ${price}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Client Name: ${fullName}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Client Email: ${email}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Text(
                                        'Client Phone: ${phoneNumber}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.2),
                                      if(status=="Pending")
                                        Row(
                                          children: [
                                            ElevatedButton.icon(
                                                onPressed: () async {

                                                  if(await RequestService.checkTimeGiven(dateTime)){
                                                    verified = RequestService.checkTimeFrom(dateTime, "5:30 PM");
                                                  }else{
                                                    verified = RequestService.checkTimeFrom(dateTime, "7:30 AM");
                                                  }
                                                  if(verified)
                                                    RequestOps.updateRequestStatus(Id, "Accepted");
                                                  else{
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text("Error"),
                                                          content: Text(
                                                              "You can only Accept a ride before 11:30 PM the day before the ride if it's morning\n"
                                                                  "and you can only Accept rides before its begining by half an hour if it's afternoon"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text("OK"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                                icon: Icon(Icons.done ,color: Colors.white),
                                                label: Text(
                                                  'Accept',
                                                  style: TextStyle(
                                                    color: Colors.white
                                                  ),
                                                ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green
                                              ),
                                            ),
                                            SizedBox(width: screenWidth*0.03),
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                if(await RequestService.checkTimeGiven(dateTime)){
                                                  verified = RequestService.checkTimeFrom(dateTime, "5:30 PM");
                                                }else{
                                                  verified = RequestService.checkTimeFrom(dateTime, "7:30 AM");
                                                }
                                                if(verified)
                                                  RequestOps.updateRequestStatus(Id, "Rejected");
                                                else{
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text("Error"),
                                                        content: Text(
                                                            "You can only Reject a ride before 11:30 PM the day before the ride if it's morning\n"
                                                                "and you can only Reject rides before its begining by half an hour if it's afternoon"),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Text("OK"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              icon: Icon(Icons.cancel ,color: Colors.black),
                                              label: Text(
                                                'Reject',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                  fontSize: 20
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red
                                              ),
                                            ),
                                          ],
                                        ),
                                        if(status=="Accepted")
                                          Row(
                                            children: [
                                               Text(
                                                  'Accepted',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                    fontSize: 20
                                                  ),
                                                ),
                                              Icon(Icons.done),
                                              SizedBox(width: screenWidth*0.03),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  RequestOps.updateRequestStatus(Id, "Done");
                                                },
                                                child: Text(
                                                  'Done',
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.pink
                                                ),
                                              ),
                                            ],
                                          ),
                                        if(status=="Rejected")
                                          Row(
                                            children: [
                                              Text(
                                                'Rejected',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20
                                                ),
                                              ),
                                              Icon(Icons.cancel,color: Colors.grey),
                                            ],
                                          ),
                                        if(status=="Done")
                                          Text(
                                            'Done',
                                            style: TextStyle(
                                                color: Colors.white,
                                              fontSize: 20
                                            ),
                                          ),
                                      ]
                                    ),
                                  Text(
                                    DateFormat('dd/MM/yyyy hh:mm a').format(dateTime),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    meetingPoint,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
