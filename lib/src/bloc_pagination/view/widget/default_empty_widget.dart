import 'package:flutter/material.dart';

class DefaultEmptyWidget extends StatelessWidget {
  /// Default loading widget
  const DefaultEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'List is empty',
      ),
    );
  }
}
