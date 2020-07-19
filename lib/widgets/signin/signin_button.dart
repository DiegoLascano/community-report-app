import 'package:flutter/material.dart';

import 'package:community_reports/widgets/common/custom_flat_button.dart';

class SignInButton extends CustomFlatButton {
  SignInButton({
    @required String text,
    Color color,
    Color disabledColor,
    Color textColor,
//    Color borderColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
            color: color,
//            borderColor: borderColor,
            disabledColor: disabledColor,
            onPressed: onPressed);
}
