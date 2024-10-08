import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../BackEnd/registration_controller.dart';
import 'home_page.dart';
import 'login_page.dart'; // Import your LoginPage

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _hidePass = true;
  final registrationController = RegistrationController(); // Initialize your registration controller
  final _formKey = GlobalKey<FormState>(); // Add a key for the form

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
              Form(
                key: _formKey,
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
                    // Email TextField
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        style: GoogleFonts.readexPro(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Email',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (newValue) {
                          registrationController.email = newValue; // Update email in the controller
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Password TextField
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextFormField(
                        style: GoogleFonts.readexPro(
                          color: Colors.white,
                        ),
                        obscureText: _hidePass,
                        onChanged: (newValue) {
                          registrationController.password = newValue; //Updates password in the controller
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Register Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) { // Check if the form is valid
                            await registrationController.authenticateWithEmailAndPassword(); // Call the registration method
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          }
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
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.readexPro(
                        color: const Color(0xFF9E9E9E),
                        fontSize: 14, // Smaller font size
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()), // Navigate to LoginPage
                        );
                      },
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.readexPro(
                          color: const Color(0xFFFFDEA7), // Color for the sign-in link
                          fontSize: 14, // Match the smaller font size
                        ),
                      ),
                    ),
                  ],
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
