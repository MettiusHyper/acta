import 'package:acta/to_do/components/custom_app_bar.dart';
import 'package:acta/to_do/servicies/user/api_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ApiState>(context);

    return PlatformScaffold(
      appBar: customAppBar(context: context, title: 'Account Settings'),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('sign out'),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              user.updateUser(null);
            },
          )
        ],
      ),
    );
  }
}
