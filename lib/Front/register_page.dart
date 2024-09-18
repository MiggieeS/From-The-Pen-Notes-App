import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'dart:async';

/*Login Page
* NOTE: Refrain from using transform.translate(), it anchors widgets to a specific x and y value, which means that the widgets won't properly move according
* to the user's screen size.
* MAIN BG COLOR: 0xFF151515
* MAIN FONT COLOR: 0xFFFFDEA7
*
* NEEDS FIXING: Hides passwords, but will reveal everything once a user types | Poor OOP | Screen compatibility issues |
* ( This is a direct copy paste of the login page, with just an additional text field)
* there are no backend processes to handle registering users
* the register button will simply go to the home page
*
* (doubt that there will be any changes here so this page's codebase will stay as it is)
*  */

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title Text
              Padding(
                padding: const EdgeInsets.only(left: 35.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Register',
                    style: GoogleFonts.readexPro(
                      color: const Color(0xFFFFDEA7),
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Subtitle Text
              Padding(
                padding: const EdgeInsets.only(left: 35.0, bottom: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Register to continue.',
                    style: GoogleFonts.readexPro(
                      color: const Color(0xFF9E9E9E),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // Username TextField
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  style: GoogleFonts.readexPro(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Username',
                    hintStyle: GoogleFonts.readexPro(
                      color: const Color(0xFF878787),
                    ),
                    labelStyle: GoogleFonts.readexPro(
                      color: const Color(0xFF798087),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFFDFDFD),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Password TextField
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  style: GoogleFonts.readexPro(
                    color: Colors.white,
                  ),
                  obscureText: _hidePass,
                  onChanged: (value) {
                    setState(() {
                      _hidePass = false;
                    });
                    Timer(const Duration(seconds: 1), () {
                      setState(() {
                        _hidePass = true;
                      });
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',
                    hintStyle: GoogleFonts.readexPro(
                      color: const Color(0xFF878787),
                    ),
                    labelStyle: GoogleFonts.readexPro(
                      color: const Color(0xFF798087),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFFDFDFD),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Confirm Password TextField
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  style: GoogleFonts.readexPro(
                    color: Colors.white,
                  ),
                  obscureText: _hidePass,
                  onChanged: (value) {
                    setState(() {
                      _hidePass = false;
                    });
                    Timer(const Duration(seconds: 1), () {
                      setState(() {
                        _hidePass = true;
                      });
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Password',
                    hintStyle: GoogleFonts.readexPro(
                      color: const Color(0xFF878787),
                    ),
                    labelStyle: GoogleFonts.readexPro(
                      color: const Color(0xFF798087),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFFDFDFD),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Register Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFDEA7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: GoogleFonts.readexPro(
                      color: const Color(0xFF222222),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Navigation to Login Page
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
