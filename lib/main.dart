import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/blocs/auth_bloc.dart';
import 'package:flutter_google_sign_in/pages/login_page.dart';
import 'package:provider/provider.dart';

void initAppCenter() async{
  final ios = defaultTargetPlatform == TargetPlatform.iOS;
  var app_secret = ios ? "123cfac9-123b-123a-123f-123273416a48" : "2ee63feb-e398-4039-bd90-8074de06c4d1";

  await AppCenter.start(app_secret, [AppCenterAnalytics.id, AppCenterCrashes.id]);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initAppCenter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context)=> AuthBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}