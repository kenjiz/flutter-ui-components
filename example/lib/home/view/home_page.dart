import 'package:example/bloc_pagination/view/demo_bloc_pagination_page.dart';
import 'package:example/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI components'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(kAppWidgetPadding),
          shrinkWrap: true,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemoBlocPaginationPage(),
                  ),
                );
              },
              child: const Text(
                'BlocPagination',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
