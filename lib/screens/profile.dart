import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final usernameController = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      firstController.text = doc['firstName'];
      lastController.text = doc['lastName'];
      usernameController.text = doc['username'];
    } catch (e) {
      print("LOAD ERROR: $e");
    }

    setState(() => loading = false);
  }

  Future<void> saveChanges() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'firstName': firstController.text.trim(),
        'lastName': lastController.text.trim(),
        'username': usernameController.text.trim(),
      });

      print("PROFILE UPDATED SUCCESSFULLY");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated!")),
      );
    } catch (e) {
      print("SAVE ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save profile: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: firstController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            TextField(
              controller: lastController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                print("Save button pressed");  
                saveChanges();
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}

