import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String hintText;
  final Widget prefixIcon;
  final String defaultText;
  final FocusNode focusNode;
  final bool obscureText;
  final TextEditingController controller;
  final Function functionValidate;
  final String parametersValidate;
  final TextInputAction actionKeyboard;
  final Function onSubmitField;
  final Function onFieldTap;
  final FormFieldSetter onsaved;

  const TextFormFieldWidget(
      {@required this.hintText,
      this.focusNode,
      this.textInputType,
      this.defaultText,
      this.obscureText = false,
      this.controller,
      this.functionValidate,
      this.parametersValidate,
      this.actionKeyboard = TextInputAction.next,
      this.onSubmitField,
      this.onFieldTap,
      this.prefixIcon,
      this.onsaved});

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Color(0xfC4C4C4)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            onSaved: widget.onsaved,
            obscureText: widget.obscureText,
            keyboardType: widget.textInputType,
            textInputAction: widget.actionKeyboard,
            focusNode: widget.focusNode,
            style: style(fsize: 20),
            initialValue: widget.defaultText,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: style(fsize: 20,color: Colors.white60),
              isDense: true,
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
                letterSpacing: 1.2,
              ),
            ),
            controller: widget.controller,
            validator: (value) {
              if (widget.functionValidate != null) {
                String resultValidate =
                    widget.functionValidate(value, widget.parametersValidate);
                if (resultValidate != null) {
                  return resultValidate;
                }

              }
              return null;
            },
            onFieldSubmitted: (value) {
              if (widget.onSubmitField != null) widget.onSubmitField();
            },
            onTap: () {
              if (widget.onFieldTap != null) widget.onFieldTap();
            },
          ),
        ),
      ),
    );
  }
}

TextStyle style({Color color = Colors.white, double fsize,}) {
  return GoogleFonts.montserrat(
      color: color, fontSize: fsize, fontWeight: FontWeight.w400);
}

String commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
