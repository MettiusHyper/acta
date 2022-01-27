import 'dart:ui';
import 'package:acta/to_do/servicies/user/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage("assets/login_background.jpg"),
              fit: BoxFit.fill,
              colorFilter: Theme.of(context).brightness == Brightness.light
                  ? ColorFilter.mode(Colors.white.withOpacity(.8), BlendMode.dstATop)
                  : ColorFilter.mode(Colors.white.withOpacity(.45), BlendMode.dstATop)),
        ),
        width: double.infinity,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Log in',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 30,
              ),
              PlatformElevatedButton(
                child: const Text('Google Auth'),
                onPressed: signInWithGoogle,
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
