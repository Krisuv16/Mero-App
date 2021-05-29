import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meroapp/main/routes.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Organics',
      theme: ThemeData(primarySwatch: Colors.indigo, fontFamily: 'OpenSans'),
      onGenerateRoute: RouterClass.generateRoute,
      initialRoute: 'login',
    );
  }
}
