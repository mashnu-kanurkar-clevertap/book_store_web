import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'providers/cart_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    CleverTapPlugin.setDebugLevel(3);
    if (kIsWeb) {
      CleverTapPlugin.init("RKR-99K-R46Z");
      CleverTapPlugin.setDebugLevel(3);
      CleverTapPlugin.addKVDataChangeListener((obj) {
        var kv = obj["kv"];
        print(kv);
      });
      return;
    }
  }
  
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      title: 'Flutter Book Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Georgia',
      ),
      home: const LoginPage(),
    );
  }
}