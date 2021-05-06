import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_app/sign_in_page.dart';
import 'package:green_app/splash.dart';

class SignUpPageState extends StatefulWidget {
  @override
  _SignUpPageStateState createState() => _SignUpPageStateState();
}

class _SignUpPageStateState extends State<SignUpPageState> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController passwordTC = TextEditingController();

  String _eMail;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 128,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Create New\nYour Account',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 33,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color(0xffB5BBC3),
                          ),
                          suffixIcon: Icon(Icons.mail),
                          helperStyle: GoogleFonts.poppins(color: Colors.red),
                          helperText:
                              'Nama pada email tidak boleh memiliki unsur pornografi',
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'eMail tidak boleh kosong';
                          } else if (value.length < 6) {
                            return 'kolom registrasi tidak boleh kurang dari 6 karakter';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _eMail = newValue;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordTC,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color(0xffB5BBC3),
                          ),
                          suffixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          } else if (value.length < 6) {
                            return 'kolom registrasi tidak boleh kurang dari 6 karakter';
                          }

                          return null;
                        },
                        onSaved: (newValue) {
                          _password = newValue;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Color(0xffB5BBC3),
                          ),
                          suffixIcon: Icon(Icons.repeat_sharp),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Konfirmasi Password tidak boleh kosong';
                          }
                          if (passwordTC.text != value) {
                            return 'Password tidak sama';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();

                            try {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _eMail, password: _password);
                            } catch (e) {
                              print(e.toString());
                            }

                            print('email : $_eMail   Password : $_password');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Splash()));
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 33,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff17A299),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sign Up',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.add_circle_outline_sharp,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ?",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPageState()));
                            },
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff17A299)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
