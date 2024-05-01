import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final FirebaseApp app;
  late final FirebaseAuth auth;
  late TextEditingController login = TextEditingController();
  late TextEditingController pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void registeruser() {
    setState(() {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: login.text, password: pwd.text);
    });
  }

  void loginuser() {
    setState(() {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: login.text, password: pwd.text);
    });
  }

  void _logout() {
    setState(() async {
      FirebaseAuth.instance.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: login,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Log in ',
                labelText: 'Email *',
              ),
              // onSaved: (String? value) {},
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Enter ur email address!';
                }

                return null;
              },
            ),
            TextFormField(
              controller: pwd,
              obscureText: true,
              decoration: const InputDecoration(
                icon: Icon(Icons.password),
                hintText: 'Password ',
                labelText: 'password *',
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Enter ur password';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  /*  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  ); */
                  loginuser();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout,
        tooltip: 'Log out',
        child: const Icon(Icons.exit_to_app),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
