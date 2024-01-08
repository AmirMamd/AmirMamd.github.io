import 'dart:convert';
import 'package:carpool_driver/Home/Requests.dart';
import 'package:carpool_driver/main.dart';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Ops/DriverOps.dart';
import '/FireBase/firebase_auth_services.dart';

class Register1 extends StatefulWidget {
  const Register1({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register1> {
  FocusNode fullNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  bool isTypingInPassword = false;
  String errorMessage = '';
  bool hasError = false;
  final RegExp emailRegex = RegExp(
    r'^[0-9]{2}[a-zA-Z][0-9]{4}@eng\.asu\.edu\.eg$',
  );
  final FirebaseAuthService _auth = new FirebaseAuthService();
  late FirebaseFirestore firestore;
  late CollectionReference drivers;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  bool isSigningUp = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _numberController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    drivers = firestore.collection('Drivers');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double modalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,

        body:Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/bg.png',
                fit: BoxFit.cover,
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
                              SizedBox(height: modalHeight*0.02),
                              Text(
                                'Welcome',
                                style: GoogleFonts.patrickHand(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 60,
                                  ),
                                ),
                              ),

                              Text(
                                '               Steer into Community\nJoin our Carpool Crew and Drive Change!',
                                style: GoogleFonts.patrickHand(
                                  textStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              SizedBox(height:modalHeight*0.05),
                              FractionallySizedBox(
                                widthFactor: 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:16.0),
                                  child: TextField(
                                    controller: _fullNameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Full Name',
                                      hintText: 'Full Name',
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
                              FractionallySizedBox(
                                widthFactor:0.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0,top: 16),
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Email",
                                      hintText: 'email@eng.asu.edu.eg',
                                      hintStyle: GoogleFonts.caveat(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black, // Set your desired text color here
                                    ),
                                  ),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:16.0),
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Password',
                                      hintText: 'Password',
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
                              FractionallySizedBox(
                                widthFactor:0.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0,top: 16),
                                  child: TextField(
                                    controller: _numberController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: "Phone Number",
                                      hintText: 'Phone Number',
                                      hintStyle: GoogleFonts.caveat(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black, // Set your desired text color here
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                hasError? errorMessage : "",
                                style: GoogleFonts.patrickHand(
                                  textStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              // SizedBox(height: modalHeight*0.05),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _signUp();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink, // Set the button background color
                                  ),
                                  child: Text(
                                    'Register',
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
                    ]
                ),
              ),
            ]
        )
    );
  }
  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String fullname = _fullNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    int number = int.parse(_numberController.text);
    if (!emailRegex.hasMatch(email)) {
      setState(() {
        isSigningUp = false;
        errorMessage = "email must be xxpxxxx@eng.asu.edu.eg";
        hasError = true;
      });
      return;
    }

    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      String? currentDriverId = await DriverOps.findDriverIdByEmail(email);
      if (user != null) {
        await drivers.doc(user.uid).set({
          'email': email.toLowerCase(),
          'fullname': fullname,
          'password': sha256.convert(utf8.encode(password)).toString(),
          'phoneNumber': number,
          // Other user-related data if needed
        });
        setState(() {
          isSigningUp = false;
          hasError = false;
          errorMessage = "";
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Requests(currentDriverId: currentDriverId)),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isSigningUp = false;
        hasError = true;
        errorMessage = e.message ?? "An error occurred";
        // e.message contains the error message from FirebaseAuthException
      });
    }
  }
}


