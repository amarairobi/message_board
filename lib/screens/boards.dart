import 'package:flutter/material.dart';
import 'profile.dart';
import 'settings.dart';
import 'chat.dart';

class BoardsScreen extends StatelessWidget {
  final boards = const [
    {'name': 'General', 'icon': Icons.chat},
    {'name': 'Homework Help', 'icon': Icons.school},
    {'name': 'Random', 'icon': Icons.casino},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Message Boards")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Menu")),
            ListTile(
              title: Text("Message Boards"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text("Profile"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfileScreen()));
              },
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SettingsScreen()));
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: boards.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(boards[index]['icon'] as IconData),
            title: Text(boards[index]['name'] as String),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    boardName: boards[index]['name'] as String,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
