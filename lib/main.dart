// ignore_for_file: deprecated_member_use

import 'dart:ffi';
import 'dart:typed_data';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:simpleworld/constant/constant.dart';
import 'package:simpleworld/widgets/simple_world_widgets.dart';
import 'package:simpleworld/widgets/splashscreen.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  await Firebase.initializeApp();
  MobileAds.instance.initialize();

  await initialize();
  await _loadImage().then((splashBytes) => {
     SharedPreferences.getInstance().then(
    (prefs) async {
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Roughnote",
          home: SplashScreen(
            userId: globalID,
            splashBytes: splashBytes,
          ),
          routes: <String, WidgetBuilder>{
            APP_SCREEN: (BuildContext context) => App(prefs, savedThemeMode),
          },
        ),
      );
    },
  )
  });
}

Future<Uint8List> _loadImage() async {
  ByteData _byteData = await rootBundle.load('assets/images/splash.png');
  return _byteData.buffer.asUint8List();
}
