import 'dart:math';

import 'package:carpool_driver/Driver/Register.dart';
import 'package:carpool_driver/Home/Requests.dart';
import 'package:carpool_driver/Ops/DriverOps.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Firebase/firebase_auth_services.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:FirebaseOptions(apiKey: 'AIzaSyDCTh6Bv0GpIO44Jge1av6y11-bbEZo6RA', appId: '1:335814966004:android:c019450dd1350e96d73ca1', messagingSenderId: '335814966004', projectId: 'carpool-c54db'));
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carpool Driver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  bool isTypingInPassword = false;
  bool hasError = false;
  String errorMessage = '';

  final FirebaseAuthService _auth = new FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                        SizedBox(height:modalHeight*0.1 ),
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
                        Text(
                          hasError? errorMessage : "",
                          style: GoogleFonts.patrickHand(
                            textStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: modalHeight*0.05),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _signIn();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink, // Set the button background color
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.patrickHand(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height:modalHeight*0.05),
                        GestureDetector(
                          onTap: () {
                            // Navigate to another page when the text is tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register1()), // Replace `AnotherPage` with your intended page
                            );
                          },

                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.blue, // Set the color of the hyperlink text
                              decoration: TextDecoration.underline, // Add an underline effect to the text
                              fontSize: 16,
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

  void _signIn() async {

    setState(() {
      isSigningIn = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    String? currentDriverId = await DriverOps.findDriverIdByEmail(email.toLowerCase());
    setState(() {
      isSigningIn = false;
    });
    if (user != null) {
      setState(() {
        hasError = false;
        errorMessage = '';
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Requests(currentDriverId: currentDriverId)),
      );
    } else {
      setState(() {
        hasError = true;
        errorMessage = 'Error signing in. Check your credentials.';
      });
    }
  }
}
