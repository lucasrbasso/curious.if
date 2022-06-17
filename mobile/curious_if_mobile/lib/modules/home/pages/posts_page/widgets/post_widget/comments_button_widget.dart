import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/core.dart';

class CommentButtonWidget extends StatelessWidget {
  final Function() onTap;
  const CommentButtonWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.comments,
                  color: Colors.grey.shade600,
                  size: 18,
                ),
                SizedBox(width: 4),
                Text("0", style: TextStyle(color: Colors.grey.shade600))
              ],
            ),
          ),
        ));
  }
}
