import 'package:flutter/material.dart';

import 'package:community_reports/widgets/common/custom_flat_button.dart';

class SocialSignInButton extends CustomFlatButton {
  SocialSignInButton({
    @required String text,
    Color color,
    Color disabledColor,
    Color textColor,
    @required String imagePath,
    VoidCallback onPressed,
  })  : assert(text != null),
        assert(imagePath != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(imagePath),
              Text(
                text,
                style: TextStyle(color: textColor),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(imagePath),
              )
            ],
          ),
          color: color,
          disabledColor: disabledColor,
          onPressed: onPressed,
        );
}
