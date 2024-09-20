import 'package:flutter/material.dart';
import 'login_page.dart';


// WILL DELETE SOON



/*NOTES!!
* Avoid using Transform.translate whenever possible. If not, properly contain widgets using containers, rows, columns or use mediaquery
* this is to ensure that no widgets will be anchored to specific x and y values on a screen. ( if anchored, this will lead to screen issues)
*
* This code is conceptual, the only working button is the log out button, there are no other pages to handle or transfer the user to other pages
*
* FUNCTIONALITIES MISSING:
*     - Help (? not entirely sure, might remove)
*     - Logout (There are no processes to handle a log out, this simply transfers the user to the Login Page
*     - Settings (UI settings = darkmode/lightmode, idk what else?, might have to make this into a button that switches to light or dark theme)
* */

class AccountDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1C1C1C),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          //This code needs to be refactored. This takes in a predetermined text name instead of using getters to grab the user's name to display
          //The reason for this is that there is no backend currently to handle this page
          const UserAccountsDrawerHeader(
            accountName: Text('My name', style: TextStyle(color: Colors.white)),
            accountEmail: Text('MyNameIs@blank.com', style: TextStyle(color: Colors.grey)),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Text('?', style: TextStyle(color: Colors.white)),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF151515),
            ),
          ),
          ListTile(
            //settings button
            leading: Icon(Icons.settings, color: Colors.white),
            title: Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            //help bnutton
            leading: Icon(Icons.help, color: Colors.white),
            title: Text('Help', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          // logout buttn
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
