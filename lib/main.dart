import 'package:flutter/material.dart';
import 'package:pfs/start_screen/screens/auth.dart';
import 'package:pfs/start_screen/screens/utils.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:pfs/firebase_options.dart';
import 'package:pfs/providers/app_provider.dart';
import 'package:pfs/providers/theme_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(lightTheme)),
        Provider(create: (context) => AppProvider(false, "en"))
      ],
      child: const MaterialAppWithTheme(),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      title: 'PFS',
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme,
      home: const AuthScreen(),
    );
  }
}
