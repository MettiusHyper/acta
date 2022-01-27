import 'package:acta/constants/themes.dart';
import 'package:acta/to_do/servicies/user/api_state.dart';
import 'package:acta/wrapper/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      initialData: null,
      child: ChangeNotifierProvider<ApiState>(
          create: (_) => ApiState(),
          builder: (context, _) {
            return MaterialApp(
              home: const Wrapper(),
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
            );
          }),
    );
  }
}
