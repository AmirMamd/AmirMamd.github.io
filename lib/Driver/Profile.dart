import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Ops/DriverOps.dart';

class Profile extends StatefulWidget {
  final String? Id;
  Profile({required this.Id});

  @override
  State<Profile> createState() => _ProfileState();
}

class Driver {
  final String name;
  final String email;
  final int phoneNumber;
  Driver({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });
}

class _ProfileState extends State<Profile> {
  Driver? driverDetails;

  @override
  void initState() {
    super.initState();
    _fetchDriverDetails();
  }

  Future<void> _fetchDriverDetails() async {
    Driver? details = await DriverOps.getDriverDetails(widget.Id);
    if (details != null) {
      setState(() {
        driverDetails = details;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double modalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
          Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/bg.png',
                fit: BoxFit.fitWidth,
              ),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(), // Placeholder for the left half
                      ),
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: modalHeight*0.05),
                              Text(
                                'Profile',
                                style: GoogleFonts.patrickHand(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                  ),
                                ),
                              ),
                              SizedBox(height:modalHeight*0.1 ),
                              Text(
                                'Name : ${driverDetails!.name}',
                                style: GoogleFonts.patrickHand(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(height: modalHeight*0.1),
                              Text(
                                'Email : ${driverDetails!.email}',
                                style: GoogleFonts.patrickHand(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              SizedBox(height: modalHeight*0.1),
                              Text(
                                'Phone Number : ${driverDetails!.phoneNumber}',
                                style: GoogleFonts.patrickHand(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                             ]
                          ),
                        ),
                      ),
                    ]
                ),
              ),
            ]
        )
    );
  }
}
