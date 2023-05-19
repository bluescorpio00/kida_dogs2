import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kida_dogs2/app/user/user_page.dart';
import 'package:kida_dogs2/main.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: const Color.fromARGB(255, 1, 16, 91),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const FirstPage()));
              }),
          title: Text(
            'Logowanie',
            style: GoogleFonts.patuaOne(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 1, 16, 91), fontSize: 20),
            ),
          )),
      body: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return  UserPage();
          }
          return HomePage(user: user);
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Jesteś zalogowany jako ${user.email}'),
    ));
  }
}
