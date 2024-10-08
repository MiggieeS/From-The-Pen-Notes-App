import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../BackEnd/auth_service.dart';
import 'profilePage.dart';

class AccountInfoPage extends StatefulWidget {
  const AccountInfoPage({Key? key}) : super(key: key);

  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  String firstName = 'Gabbers';
  String lastName = 'Gabbers';
  String email = 'gabbers@gmail.com';
  bool isPasswordVisible = false;

  //changepass logic
  void _showChangePasswordDialog() {
    String currentPassword = '';
    String newPassword = '';
    String confirmNewPassword = '';
    bool isLoading = false; // Loading state variable

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1C),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change Password',
                style: GoogleFonts.readexPro(
                  color: const Color(0xFFFFDEA7),
                  fontSize: 18,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFFFFDEA7)),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: !isPasswordVisible,
                style: GoogleFonts.readexPro(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Current Password',
                  hintStyle: GoogleFonts.readexPro(color: const Color(0xFF878787)),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) => currentPassword = value,
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: !isPasswordVisible,
                style: GoogleFonts.readexPro(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'New Password',
                  hintStyle: GoogleFonts.readexPro(color: const Color(0xFF878787)),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) => newPassword = value,
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: !isPasswordVisible,
                style: GoogleFonts.readexPro(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Confirm New Password',
                  hintStyle: GoogleFonts.readexPro(color: const Color(0xFF878787)),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) => confirmNewPassword = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                //password validation
                if (currentPassword.isEmpty || newPassword.isEmpty || confirmNewPassword.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields!', style: GoogleFonts.readexPro())),
                  );
                  return;
                }

                if (newPassword != confirmNewPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match!', style: GoogleFonts.readexPro())),
                  );
                  return;
                }

                setState(() {
                  isLoading = true;
                });

                try {
                  //call authservice for change password
                  await AuthService.changePassword(
                    currentPassword: currentPassword,
                    newPassword: newPassword,
                  );
                  Navigator.pop(context); // Close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password successfully changed!', style: GoogleFonts.readexPro())),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString(), style: GoogleFonts.readexPro())),
                  );
                } finally {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Text('Confirm', style: GoogleFonts.readexPro(color: const Color(0xFFFFDEA7))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFFFFDEA7)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),
        title: Text(
          'Account Information',
          style: GoogleFonts.readexPro(
            color: const Color(0xFFFFDEA7),
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('First Name', firstName),
            _buildInfoRow('Last Name', lastName),
            _buildInfoRow('Email', email),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFDEA7),
                ),
                onPressed: _showChangePasswordDialog,
                child: Text(
                  'Change Password',
                  style: GoogleFonts.readexPro(
                    color: const Color(0xFF474747),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.readexPro(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.readexPro(
              color: const Color(0xFFFFDEA7),
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

