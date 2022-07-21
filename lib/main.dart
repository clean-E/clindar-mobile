import 'package:clindar_mobile/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphQL/config.dart';
import 'provider/google_sign_in.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'MainPage';
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initClient(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData.dark().copyWith(accentColor: Colors.indigo),
        home: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: HomePage(),
        ),
      ),
    );
  }
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => GoogleSignInProvider(),
//       child: GraphQLProvider(
//         client: Config.initClient(),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: title,
//           theme: ThemeData.dark().copyWith(accentColor: Colors.indigo),
//           home: HomePage(),
//         ),
//       ),
//     );
//   }
}
