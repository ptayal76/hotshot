import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class modified_text extends StatelessWidget {
  final String text;
  final Color color;
  final double size;

  const modified_text(
      {Key? key, required this.text, this.color = Colors.white, this.size = 14})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.acme(color: color, fontSize: size));
  }
}
