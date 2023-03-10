import 'package:flutter/material.dart';

// charts constant
const ctPrimaryColor = Color(0xFF2697FF);
const ctSecondaryColor = Color(0xFF2A2D3E);
const ctBgColor = Color(0xFF212332);
const ctContainer = Color.fromRGBO(249, 249, 249, 1);
const ctDarkGray = Color(0xFF757575);
const ctPadding = 16.0;

// authentication constant
final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.black12,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
