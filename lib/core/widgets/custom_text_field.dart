import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.obsecure = false,
      this.suffix,
      this.suffixPressed,
      this.prefix});

  final String hintText;
  final TextEditingController? controller;
  bool? obsecure;
  IconData? suffix;
  IconData? prefix;
  Function()? suffixPressed;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.white,
      ),
      obscureText: obsecure!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(
            prefix,color: Colors.white,
          ),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                    color: Colors.white,
                  ))
              : null,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          enabledBorder: textFormBorder(),
          focusedBorder: textFocusBorder(),
          border: textFormBorder()),
    );
  }
}

OutlineInputBorder textFormBorder() {
  return  OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
    color:  Colors.white,
  ));
}

OutlineInputBorder textFocusBorder() {
  return  OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.0),
      borderSide: const BorderSide(
    color:  Color.fromARGB(255, 155, 192, 232),
  ));
}
