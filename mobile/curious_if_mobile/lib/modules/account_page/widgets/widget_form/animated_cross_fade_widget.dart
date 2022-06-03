import 'package:flutter/material.dart';

class AnimatedCrossFadeWidget extends StatelessWidget {
  final Widget firstChild;
  final Widget secondChild;
  final bool isFirst;
  const AnimatedCrossFadeWidget({
    Key? key,
    required this.firstChild,
    required this.secondChild,
    required this.isFirst,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 600),
      sizeCurve: Curves.decelerate,
      layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
        return Stack(
          children: [
            Align(key: bottomChildKey, child: bottomChild),
            Align(key: topChildKey, child: topChild),
          ],
        );
      },
      firstChild: isFirst ? firstChild : Container(),
      secondChild: isFirst ? Container() : secondChild,
      crossFadeState:
          isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );
  }
}
