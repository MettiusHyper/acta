import 'package:acta/components/custom_app_bar.dart';
import 'package:acta/screens/add_list/components/add_list_column.dart';
import 'package:acta/screens/add_list/components/list_state.dart';
import 'package:acta/screens/edit_list/components/edit_list_pop.dart';
import 'package:acta/servicies/user/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class EditList extends StatelessWidget {
  const EditList({Key? key, required this.editList}) : super(key: key);
  final ApiList editList;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListState>(
      create: (_) => ListState(),
      builder: (context, _) {
        //initialization
        final list = Provider.of<ListState>(context);
        Future.delayed(Duration.zero, () {
          if (list.name.text.isEmpty) {
            list.update(
              newName: editList.name,
              newColor: editList.color,
              newEmoji: editList.emoji,
            );
          }
        });
        return list.name.text.isEmpty
            ? Center(child: PlatformCircularProgressIndicator())
            : PlatformScaffold(
                appBar: customAppBar(
                  context: context,
                  backButton: true,
                  trailingCupertino: GestureDetector(
                    onTap: () async => editListAndPop(context, editList.id),
                    child: const Icon(Icons.check, size: 25, color: Colors.blue),
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
                    onPressed: () async => editListAndPop(context, editList.id),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                ),
              );
      },
    );
  }
}
