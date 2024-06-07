import 'package:flutter/material.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

import '../model/user.dart';

class PaginationTest extends StatefulWidget {
  const PaginationTest({super.key});

  @override
  State<PaginationTest> createState() => _PaginationTestState();
}

class _PaginationTestState extends State<PaginationTest> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomListView<User>(
            key: const ValueKey('CustomListView'),
            itemBuilder: (context, index, item) {
              return ListTile(
                title: Text(
                  item.name,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
