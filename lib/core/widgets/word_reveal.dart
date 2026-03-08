import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Reveals text word-by-word with a staggered fade+slide-up animation.
/// Handles embedded newlines by rendering each line in its own [Wrap].
/// Falls back to plain [Text] when animations are disabled.
class WordReveal extends StatelessWidget {
  const WordReveal({
    required this.text,
    required this.style,
    this.baseDelay = Duration.zero,
    this.wordDelay = const Duration(milliseconds: 40),
    this.duration = const Duration(milliseconds: 450),
    super.key,
  });

  final String text;
  final TextStyle style;
  final Duration baseDelay;
  final Duration wordDelay;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).disableAnimations) {
      return Text(text, style: style);
    }

    final lines = text.split('\n');
    var wordIndex = 0;
    final children = <Widget>[];

    for (final line in lines) {
      if (line.isEmpty) {
        children.add(const SizedBox(height: 12));
        continue;
      }

      final words = line.split(' ').where((w) => w.isNotEmpty).toList();
      final startIndex = wordIndex;
      wordIndex += words.length;

      children.add(
        Wrap(
          children: [
            for (var i = 0; i < words.length; i++)
              Text('${words[i]} ', style: style)
                  .animate(delay: baseDelay + wordDelay * (startIndex + i))
                  .fadeIn(duration: duration)
                  .moveY(
                    begin: 8,
                    end: 0,
                    duration: duration,
                    curve: Curves.easeOut,
                  ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
