import 'package:acta/constants/acta_icons_icons.dart';
import 'package:acta/to_do/servicies/user/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Image.asset(
                'assets/icon_login.png',
                width: 55,
              ),
            ),
            Text(
              'Welcome to Acta',
              style: Theme.of(context).textTheme.headline1,
            ),
            Text('Please log in to sync your content',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w300, fontSize: 16)),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 10000,
              height: 50,
              child: ElevatedButton(
                child: Row(
                  children: const [
                    Spacer(),
                    Icon(ActaIcons.google),
                    SizedBox(width: 10),
                    Text(
                      'Continue with google',
                      overflow: TextOverflow.visible,
                    ),
                    Spacer(),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xffd3695f)),
                  side: MaterialStateProperty.all(const BorderSide(width: 2, color: Color(0xffb45c4a))),
                ),
                onPressed: signInWithGoogle,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
