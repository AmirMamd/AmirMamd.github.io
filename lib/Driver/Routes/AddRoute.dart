import 'package:carpool_driver/Service/AddRouteService.dart';
import 'package:carpool_driver/Ops/AddRouteOps.dart';
import 'package:carpool_driver/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Home/Requests.dart';
import '../Profile.dart';


class AddRoutePage extends StatefulWidget {

  final String? driverId;

  AddRoutePage({required this.driverId});

  @override
  State<AddRoutePage> createState() => _AddRoutePageState();
}

class _AddRoutePageState extends State<AddRoutePage> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String errorMessage = '';

  Future<void> addRoute() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    setState(() {
      errorMessage = '';
    });
    if (AddRouteService.areFieldsEmpty(
        nameController.text, imageUrlController.text, priceController.text)) {
      setState(() {
        errorMessage = 'Some fields are missing';
      });
      return;
    }
    try {
      if (widget.driverId != null) {
        String enteredName = nameController.text;

        bool routeExists = await AddRouteOps.checkIfRouteExists(widget.driverId!, enteredName);
        if (routeExists) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Route Exists'),
                content: Text('The route name already exists for this driver.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        else {
          // If the route doesn't exist for any driver, add the route
          await AddRouteOps.addRoute(
            widget.driverId!,
            imageUrlController.text,
            nameController.text,
            priceController.text,
          );
          // Clear text fields after adding the route
          nameController.clear();
          imageUrlController.clear();
          priceController.clear();
        }

      } else {
        print('Driver ID is null');
      }
    } catch (e) {
      // Handle errors here
      print('Error adding route: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Requests(currentDriverId: widget.driverId)));
          },
        ),
        centerTitle: true,
        title: Text(
          "Add Route",
          style: GoogleFonts.pangolin(
            textStyle: TextStyle(fontSize: screenHeight * 0.04, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,

        actions: [
          IconButton(
            icon: Icon(Icons.person,color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Profile(Id: widget.driverId)), // Replace with your profile page
              );
            },
          ),

          Padding(
            padding: EdgeInsets.only(right: screenHeight*0.04, left: screenWidth*0.005),
            child: IconButton(
              icon: Icon(Icons.logout,color: Colors.white),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(), // Replace with your OrderHistory page
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body:
      SingleChildScrollView(
        child:
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.35, vertical: screenHeight * 0.14),
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FractionallySizedBox(
                widthFactor: 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: TextField(
                    controller: imageUrlController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Image Path',
                      hintText: 'Enter Destination Image Path',
                      hintStyle: GoogleFonts.caveat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // TextFormField(
              //   controller: imagePathController,
              //   decoration: InputDecoration(labelText: 'Image Path'),
              // ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Destination',
                      hintText: 'Enter Destination',
                      hintStyle: GoogleFonts.caveat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              FractionallySizedBox(
                widthFactor: 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(top:16.0),
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Price',
                      hintText: 'Enter price',
                      hintStyle: GoogleFonts.caveat(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.1),

              if (errorMessage.isNotEmpty) // Check if there's an error message
                Text(
                  errorMessage,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: screenHeight*0.027// Customize the error text color
                  ),
                ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    addRoute();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink, // Set the button background color
                  ),
                  child: Text(
                    'Add Route',
                    style: GoogleFonts.patrickHand(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ),
      ),

    );
  }
}