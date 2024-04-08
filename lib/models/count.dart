import 'package:flutter/widgets.dart';

class Count {
  final DateTime since;
  final String name;
  final String? emoji;
  final Color color;

  const Count({
    required this.since,
    required this.name,
    required this.emoji,
    required this.color,
  });
}
