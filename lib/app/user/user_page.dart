import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatefulWidget {
  UserPage({
    required this.changeTitle,
    super.key,
  });
  final Function(bool) changeTitle;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isCreatingAccount == true
                  ? 'Zarejestruj się'
                  : 'Witaj w KIDA DOGS!',
              style: GoogleFonts.calistoga(
                  fontSize: 30,
                  textStyle:
                      const TextStyle(color: Color.fromARGB(255, 1, 16, 91))),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'E-mail',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              controller: widget.emailController,
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
              controller: widget.passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(errorMessage),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (isCreatingAccount == true) {
                    //rejestracja
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: widget.emailController.text,
                              password: widget.passwordController.text);
                    } catch (error) {
                      setState(() {
                        errorMessage = 'Coś poszło nie tak';
                      });
                    }
                  } else {
                    //logowanie
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: widget.emailController.text,
                          password: widget.passwordController.text);
                    } catch (error) {
                      setState(() {
                        errorMessage = 'Coś poszło nie tak';
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 16, 91)),
                child: Text(
                    isCreatingAccount == true ? 'Zarejestruj' : 'Zaloguj',
                    style: GoogleFonts.calistoga(
                        fontSize: 17,
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)))),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (isCreatingAccount == false) ...[
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.changeTitle(false);
                      isCreatingAccount = true;
                    });
                  },
                  child: Text(
                    'Utwórz konto',
                    style: GoogleFonts.calistoga(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 1, 16, 91))),
                  ))
            ],
            if (isCreatingAccount == true) ...[
              TextButton(
                  onPressed: () {
                    setState(() {
                      widget.changeTitle(true);
                      isCreatingAccount = false;
                    });
                  },
                  child: Text('Masz już konto?',
                      style: GoogleFonts.calistoga(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 1, 16, 91)))))
            ]
          ],
        ),
      ),
    );
  }
}
