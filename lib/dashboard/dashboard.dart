import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/notes_controller.dart';
import '../providers/theme_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  void _writeData() async {
    // await database.ref("users").set({});
    // await database.ref("settings").set({
    //   "language": ["en", "ru"],
    //   "base_currency": ["USD", "EUR", "RUB", "THB"]
    // });
    // await database.ref("currencies").set(["USD", "EUR", "RUB", "THB"]);
    await NotesController().addNote(context, "uid123", {"title": "NEw note!"});
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PFS'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              icon: themeProvider.getTheme == lightTheme
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
              onPressed: () {
                themeProvider.setTheme(themeProvider.getTheme == lightTheme
                    ? darkTheme
                    : lightTheme);
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          //todo replace to column
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Not implemented yet',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _writeData();
              },
              child: const Text('Write data'),
            ),
          ],
        ),
      ),
    );
  }
}
