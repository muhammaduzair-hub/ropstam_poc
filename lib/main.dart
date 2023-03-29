import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ropstam_poc/di/provider_setup.dart';
import 'package:ropstam_poc/ui/views/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MediaQuery(
      data: new MediaQueryData.fromWindow(ui.window),
      child: Directionality(textDirection: TextDirection.rtl, child: MyApp()),
    ));
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: RootRestorationScope(
        restorationId: 'root',
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashView(),
        ),
      ),
    );
  }
}
