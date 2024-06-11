import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';

import '../widget/appbar.dart';

class UserListPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Users",
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('User').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final userData = user.data() as Map<String, dynamic>?;

              final profileImageUrl = userData?['profileImageUrl'];
              final name = userData?['name'] ?? 'No Name';
              final phone = userData?['phone'] ?? 'No Phone';
              final age = userData?['age']?.toString() ?? 'No Age';

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppThemeData.primaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: profileImageUrl != null
                          ? NetworkImage(profileImageUrl)
                          : const AssetImage('assets/Images/img_4.png') as ImageProvider,
                    ),
                    title: Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      phone,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      "Age: $age",
                      style: const TextStyle(color: Colors.white),
                    ),
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
