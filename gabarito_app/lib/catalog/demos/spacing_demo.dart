import 'package:flutter/material.dart';

class SpacingDemoScreen extends StatelessWidget {
  const SpacingDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color containerColor = Theme.of(context).colorScheme.primaryContainer;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: () => Navigator.of(context).maybePop()),
        title: const Text('Spacing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List<Widget>.generate(
            6,
            (int i) => Container(
              width: 40 + i * 8,
              height: 40,
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


