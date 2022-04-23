import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/core.dart';

class ButtonFormInput extends StatelessWidget {
  final Function onTap;
  const ButtonFormInput({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  backgroundColor: MaterialStateProperty.all(
                      AppTheme.colors.backgroundButton)),
              onPressed: () => onTap(),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Cadastrar",
                  style: AppTheme.textStyles.textButtonInput,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
