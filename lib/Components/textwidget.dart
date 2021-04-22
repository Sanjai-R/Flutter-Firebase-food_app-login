import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextWidget extends StatelessWidget {
  final String text;
  final Color color ;
  final FontWeight weight;
  final double size;
  TextWidget({
  @required this.text, 
  this.color = Colors.white, 
  this.weight,
  @required this.size});
  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: GoogleFonts.montserrat(
        color: color,
        fontSize: size,
        fontWeight: weight
      )
    );
  }
}
