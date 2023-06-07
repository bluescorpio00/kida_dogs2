import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kida_dogs2/app/user/user_page.dart';
import 'package:kida_dogs2/main.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  bool isLoggingIn = true;

  void toggleLoginRegistration(bool isLoginPage) {
    setState(() {
      isLoggingIn = isLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = isLoggingIn ? 'Logowanie' : 'Rejestracja';

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
            title,
            style: GoogleFonts.calistoga(
              textStyle: const TextStyle(
                  color: Color.fromARGB(255, 1, 16, 91), fontSize: 20),
            ),
          )),
      body: LoginPage(changeTitle: toggleLoginRegistration),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({
    required this.changeTitle,
    super.key,
  });
  final Function(bool) changeTitle;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if (user == null) {
            return UserPage(changeTitle: changeTitle);
          }
          return HomePage(user: user);
        });
  }
}

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
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return Center(
            child: Text('jeden'),
          );
        }
        if (currentIndex == 1) {
          return Center(
            child: Text('dwa'),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Jesteś zalogowany jako ${widget.user.email}'),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Wyloguj'))
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.pets), label: 'Aktywności'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'Statystyki'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Ja'),
          ]),
    );
  }
}
