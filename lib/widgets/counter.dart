import 'package:flutter/material.dart';
import 'dart:math' as math;

class Counter extends StatelessWidget {
  final Duration duration;
  final Color color;
  final String? emoji;
  final double emojiSize;

  const Counter({
    required this.duration,
    required this.color,
    required this.emoji,
    this.emojiSize = 64.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final emojis = (size.width * size.height) ~/ (math.pow(emojiSize, 2));

    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(color: color),
          ),
        ),
        if (emoji != null && emoji != "")
          Positioned.fill(
            child: Opacity(
              opacity: .2,
              child: Transform.rotate(
                angle: math.pi / 12,
                child: Transform.scale(
                  scale: 1.5,
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 64),
                    child: Wrap(
                      children: List.generate(emojis, (index) => Text(emoji!)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        Center(
          child: DefaultTextStyle(
            style: (theme.textTheme.headlineLarge!).copyWith(
              fontWeight: FontWeight.bold,
              color:
                  ThemeData.estimateBrightnessForColor(color) == Brightness.dark
                      ? Colors.white
                      : Colors.black,
            ),
            child: Wrap(
              children: [
                if (duration.inDays > 0) Text("${duration.inDays}d"),
                const Text(" "),
                Text(
                    "${(duration.inHours % 24).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
