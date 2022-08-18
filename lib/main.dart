import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uts_reservat/provider/authProvider.dart';
import 'package:uts_reservat/provider/categoriesProvider.dart';
import 'package:uts_reservat/provider/ownerPlaceProvider.dart';
import 'package:uts_reservat/provider/placeProvider.dart';
import 'package:uts_reservat/provider/reservationClientProvider.dart';
import 'package:uts_reservat/provider/securityMeasuresProvider.dart';
import 'package:uts_reservat/res/colors.dart';
import 'package:uts_reservat/routes/routes.dart';
import 'package:uts_reservat/sessions/sessionManager.dart';
import 'package:uts_reservat/utils/constantsUtil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SessionManager prefs = SessionManager();
  await prefs.initPrefs();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final prefs = SessionManager();

  @override
  void initState() {
    super.initState();
    /*final _notificationPush = NotificationPushService();
    _notificationPush.initNotification();
    _notificationPush.messageStream.listen((data) {
      addLog(message: data);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlaceProvider()),
        ChangeNotifierProvider(create: (context) => OwnerPlaceProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => SecurityMeasuresProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ReservationClientProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: laRioja,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: placesHomeRoute,
          routes: getApplicationRoutes()),
    );
  }
}
