// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'guide.card.dart';

class HowToGuides extends StatefulWidget {
  static const String routeName = "/howToGuides";

  const HowToGuides({ Key? key }) : super(key: key);

  @override
  State<HowToGuides> createState() => _HowToGuidesState();
}

class _HowToGuidesState extends State<HowToGuides> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        elevation: 0.2,
        backgroundColor: Colors.white,
        title: const Text("How To Guides",
            style: TextStyle(
                fontFamily: "Cerebri Sans",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold))),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(

                        radius: 100,
                        backgroundImage: AssetImage('assets/faq.png'),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 22,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Opacity(opacity: 0.5,child: Text("Registration",style: TextStyle(fontFamily: "Cerebri Sans",fontSize: 17),)),
                    ),
                    SizedBox(height: 8,),
                    GuideCard(title: "Registration"),
                    Divider(height: 0,),
                    GuideCard(title: "Login"),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Opacity(opacity: 0.5,child: Text("Account",style: TextStyle(fontFamily: "Cerebri Sans",fontSize: 17),)),
                    ),
                    SizedBox(height: 8,),
                    GuideCard(title: "Account Information"),
                    Divider(height: 0,),
                    GuideCard(title: "Upload profile"),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Opacity(opacity: 0.5,child: Text("Dashboard",style: TextStyle(fontFamily: "Cerebri Sans",fontSize: 17),)),
                    ),
                    SizedBox(height: 8,),
                    GuideCard(title: "Dashboard"),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Opacity(opacity: 0.5,child: Text("Other Settings",style: TextStyle(fontFamily: "Cerebri Sans",fontSize: 17),)),
                    ),
                    SizedBox(height: 8,),
                    GuideCard(title: "Notifications"),
                    Divider(height: 0,),
                    GuideCard(title: "Support"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}