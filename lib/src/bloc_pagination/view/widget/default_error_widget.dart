import 'package:flutter/material.dart';

class DefaultErrorWidget extends StatelessWidget {
  /// Default loading widget
  const DefaultErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Something went wrong, please try again later',
      ),
    );
  }
}
