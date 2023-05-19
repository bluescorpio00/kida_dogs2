import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatelessWidget {
  UserPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Witaj w KIDA DOGS!',
              style: GoogleFonts.patuaOne(
                  fontSize: 30,
                  textStyle: TextStyle(color: Color.fromARGB(255, 1, 16, 91))),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'E-mail',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Hasło',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                  } catch (error) {
                    print(error);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 16, 91)),
                child: Text('Zaloguj',
                    style: GoogleFonts.patuaOne(
                        fontSize: 17,
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)))),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
