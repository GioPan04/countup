import 'dart:async';

import 'package:countup/models/count.dart';
import 'package:countup/widgets/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counts = [
  Count(
    since: DateTime(2024, 2, 19),
    name: "Gym",
    emoji: "🏋️‍♂️",
    color: Colors.red,
  ),
  Count(
    since: DateTime(2004, 12, 30),
    name: "Birth",
    emoji: null,
    color: Colors.blue,
  )
];

final _countsProvider = StreamProvider<List<(Duration, Count)>>(
  (ref) async* {
    parse() {
      final now = DateTime.now();
      return counts.map((e) => (now.difference(e.since), e)).toList();
    }

    final timer = Timer.periodic(const Duration(seconds: 1), (_) {
      ref.state = AsyncData(parse());
    });

    ref.onDispose(timer.cancel);

    yield parse();
  },
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref.watch(_countsProvider);

    return Scaffold(
      body: switch (counts) {
        AsyncData(:final value) => PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: value.length,
            itemBuilder: (context, i) => Counter(
              duration: value[i].$1,
              color: value[i].$2.color,
              emoji: value[i].$2.emoji,
            ),
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
