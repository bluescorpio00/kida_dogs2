import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatefulWidget {
  UserPage({
    super.key,
  });

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
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isCreatingAccount == true
                  ? 'Zarejestruj sie'
                  : 'Witaj w KIDA DOGS!',
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
            SizedBox(
              height: 40,
            ),
            Text(errorMessage),
            const SizedBox(
              height: 40,
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

                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text);
                  } catch (error) {
                    setState(() {
                      errorMessage = 'Coś poszło nie tak';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 16, 91)),
                child: Text(
                    isCreatingAccount == true ? 'Zarejestruj' : 'Zaloguj',
                    style: GoogleFonts.patuaOne(
                        fontSize: 17,
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)))),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            if (isCreatingAccount == false) ...[
              TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: Text('Utwórz konto'))
            ],
            if (isCreatingAccount == true) ...[
              TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  },
                  child: const Text('Masz już konto?'))
            ]
          ],
        ),
      ),
    ));
  }
}
