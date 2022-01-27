import 'package:acta/components/custom_app_bar.dart';
import 'package:acta/screens/add_task/add_task.dart';
import 'package:acta/screens/home/components/home_column.dart';
import 'package:acta/servicies/user/api_state.dart';
import 'package:acta/servicies/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ApiState>(context);

    Future.delayed(Duration.zero, () async {
      if (user.current == null) {
        await user.asyncUpdateUser();
      }
    });

    return user.current == null
        ? Center(child: PlatformCircularProgressIndicator())
        : PlatformScaffold(
            appBar: customAppBar(
              context: context,
              title: greeting() + ', ' + (FirebaseAuth.instance.currentUser!.displayName ?? ''),
              trailingCupertino: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTask()));
                },
                child: Icon(context.platformIcons.add, size: 26, color: Colors.blue),
              ),
            ),
            body: const HomeColumn(),
            material: (_, __) => MaterialScaffoldData(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTask()));
                },
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(context.platformIcons.add, color: Colors.white),
              ),
            ),
          );
  }
}
