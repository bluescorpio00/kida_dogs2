import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kida_dogs2/app/home/activities/activities_page_content.dart';
import 'package:kida_dogs2/app/home/add_activities/add_activities_page_content.dart';
import 'package:kida_dogs2/app/home/my_account/my_account_page_content.dart';
import 'package:kida_dogs2/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KIDA & DOGS'),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const ActivitiesPageContent();
        }
        if (currentIndex == 1) {
          return const AddActivitiesPageContent();
        }

        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Aktywności'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Dodaj'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Moje konto'),
        ],
      ),
    );
  }
}



