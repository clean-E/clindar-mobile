import 'package:clindar_mobile/provider/login_service.dart';
import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphQL/config.dart';
import 'provider/google_sign_in.dart';

Future main() async {
  initializeDateFormatting('ko_KR', null);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initClient(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(backgroundColor: LightColors.kDarkYellow),
        home: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: LoginService(),
        ),
      ),
    );
  }
}
