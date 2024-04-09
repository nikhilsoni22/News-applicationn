import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practice/backup/img_back.dart';
import 'package:practice/backup/spinkit_up.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice/home_screen/home_screen.dart';

class splashScreen extends StatefulWidget {
  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homeScreen(),));
    });
  }

  @override
  Widget build(BuildContext context) {

     final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

            child: Image.asset(splashImg),

          ),
          SizedBox(
            height: height * 0.04,
          ),

          Text("TOP HEADLINE",style: GoogleFonts.acme(
            fontWeight: FontWeight.w700,
            letterSpacing: 3,
          ),),
          SizedBox(
            height: height * 0.04,
          ),
          circleSpin,
          SizedBox(
            height: height * .3,
          ),
          Text("@Nikhil Soni",style: GoogleFonts.acme(),),

        ],
      ),
    );

  }
}
