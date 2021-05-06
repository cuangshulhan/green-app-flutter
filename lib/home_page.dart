import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_app/header.dart';
import 'package:green_app/splash.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String judul = 'Home Page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Splash()));
              })
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              judul = 'Home Page';
                            });
                          },
                          child: Header(nama: 'Home'),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              judul = 'Courses Page';
                            });
                          },
                          child: Header(nama: 'Courses'),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              judul = 'Reviews Page';
                            });
                          },
                          child: Header(nama: 'Reviews'),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              judul = 'My Settings Page';
                            });
                          },
                          child: Header(nama: 'My Settings'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
