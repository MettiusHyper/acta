import 'package:acta/components/custom_app_bar.dart';
import 'package:acta/screens/add_list/components/add_list_column.dart';
import 'package:acta/screens/add_list/components/add_list_pop.dart';
import 'package:acta/screens/add_list/components/list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class AddList extends StatelessWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListState>(
      create: (_) => ListState(),
      builder: (context, _) {
        //initialization
        return PlatformScaffold(
          appBar: customAppBar(
            context: context,
            backButton: true,
            trailingCupertino: GestureDetector(
              onTap: () async => addListAndPop(context),
              child: const Icon(Icons.check, size: 26, color: Colors.blue),
            ),
          ),
          body: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: AddListColumn(),
            ),
          ),
          material: (_, __) => MaterialScaffoldData(
            floatingActionButton: FloatingActionButton(
              onPressed: () async => addListAndPop(context),
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.check, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
