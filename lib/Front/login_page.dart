import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'register_page.dart';
import 'dart:async';


/*Login Page
* NOTE: Refrain from using transform.translate(), it anchors widgets to a specific x and y value, which means that the widgets won't properly move according
* to the user's  screen size.
*
* all pages can go back to the previous page via android's back button, this is so that we can easily look at our pages without having to restart the app to go back a page.
*
* MAIN BG COLOR: 0xFF151515
* MAIN FONT COLOR: 0xFFFFDEA7
*
* NEEDS FIXING: Hides passwords, but will reveal everything once a user types | Poor OOP | Screen compatibility issues
* user name and password text fields are non functional, simply click the login button to proceed to the home page
* register here button transfers to register page
*
* (doubt that there will be any changes here so this page's codebase will stay as it is)
*  */


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //Login text
    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 35.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
                    style: GoogleFonts.readexPro(
                      color: const Color(0xFFFFDEA7),
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Sign in to continue text
              Padding(
                padding: const EdgeInsets.only(left: 35.0, bottom: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please sign in to continue.',
                    style: GoogleFonts.readexPro(
                      color: const Color(0xFF9E9E9E),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                // Username textfield box
                //Use mediaquery to auto automatically scale our boxes to a device's screen
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
              const SizedBox(height: 30),
              SizedBox(
                //password textfield box
                //Use mediaquery to auto automatically scale our boxes to a device's screen
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
              const SizedBox(height: 30),

              SizedBox(
                //Login button => main screen. // WILL automatically put you to home notes page, there is no back-end to handle this process currently.
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
                    'Login',
                    style: GoogleFonts.readexPro(
                      color: const Color(0xFF222222),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              //clickable text "here"
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.readexPro(
                      color: const Color(0xFF9E9E9E),
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(text: 'No account? Register '),
                      TextSpan(
                        text: 'Here!',
                        style: GoogleFonts.readexPro(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blueAccent,
                          decorationThickness: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
