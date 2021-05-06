import 'package:flutter/material.dart';
import 'package:green_app/auth_services.dart';
import 'package:green_app/sign_up_page.dart';
import 'package:green_app/splash.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPageState extends StatefulWidget {
  @override
  _SignInPageStateState createState() => _SignInPageStateState();
}

class _SignInPageStateState extends State<SignInPageState> {
  final _formkey = GlobalKey<FormState>();

  String _eMail;
  String _password;
  String _showError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 128,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Welcome Back,\nUsers',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_showError,
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Color(0xffB5BBC3),
                            ),
                            suffixIcon: Icon(Icons.mail),
                            labelText: 'Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                          onSaved: (newValue) {
                            _eMail = newValue;
                          },
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        TextFormField(
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
                        InkWell(
                          onTap: () async {
                            if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();

                              String data =
                                  await AuthServices.signIn(_eMail, _password);

                              if (data == _eMail) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Splash()));
                              } else {
                                print(data);

                                setState(() {
                                  _showError = data;
                                });
                              }

                              // try {
                              //   FirebaseAuth.instance.signInWithEmailAndPassword(
                              //       email: _eMail, password: _password);
                              // } catch (e) {
                              //   print(e.toString());
                              // }

                              // print('email : $_eMail   Password : $_password');
                              // Navigator.pushReplacement(context,
                              //     MaterialPageRoute(builder: (context) => Splash()));
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
                                  'Sign In',
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
                                  Icons.login,
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
                              "Don't have an account ?",
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
                                        builder: (context) =>
                                            SignUpPageState()));
                              },
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: Color(0xff17A299)),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
