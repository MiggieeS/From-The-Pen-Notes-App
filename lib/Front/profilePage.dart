import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart'; // Import the LoginPage
import 'home_page.dart'; // Import HomePage
import 'acctInfo.dart'; // Import the acctInfo page

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Color(0xFFFFDEA7)),
          onPressed: () {
            // Navigate back to HomePage when "X" is pressed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.readexPro(
            color: const Color(0xFFFFDEA7),
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile picture and name
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://www.w3schools.com/w3images/avatar2.png', // Replace with profile picture
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Gabbers', // Replace with dynamic user name
            style: GoogleFonts.readexPro(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          // List of cards with Account Info, Settings, and Log Out
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                _buildProfileCard(
                  icon: Icons.person,
                  title: 'Account Information',
                  onTap: () {
                    // Navigate to the AccountInfoPage when this button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountInfoPage(),
                      ),
                    );
                  },
                ),
                _buildProfileCard(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    // Handle Settings tap
                  },
                ),
                _buildProfileCard(
                  icon: Icons.logout,
                  title: 'Log Out',
                  onTap: () {
                    _showLogoutConfirmation(context); // Show confirmation dialog
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build profile option cards
  Widget _buildProfileCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color(0xFF474747),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFFFDEA7)),
        title: Text(
          title,
          style: GoogleFonts.readexPro(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  // Function to show the logout confirmation dialog
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1C1C),
          title: Text(
            'Log Out',
            style: GoogleFonts.readexPro(
              color: const Color(0xFFFFDEA7),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to log out of your account?',
            style: GoogleFonts.readexPro(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog (No)
              },
              child: Text(
                'No',
                style: GoogleFonts.readexPro(
                  color: const Color(0xFFFFDEA7),
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false, // Log out and remove stack
                );
              },
              child: Text(
                'Yes',
                style: GoogleFonts.readexPro(
                  color: const Color(0xFFFFDEA7),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
