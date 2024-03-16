import 'package:flutter/material.dart';
import 'package:vinnovate/utils/colors_utils.dart';

// ignore: must_be_immutable
class TextfieldCustom extends StatelessWidget {
  final double height;
  final String hintText;
  final String title;
  final bool obscure;
  final IconData prefixIcon;
  Widget? sufixIcon;
  final TextEditingController controller;
  final FormFieldValidator validator;
  TextInputAction? textInputAction;
  TextInputType? textInputType;

  TextfieldCustom(
      {super.key,
      required this.height,
      required this.hintText,
      required this.title,
      required this.obscure,
      required this.controller,
      required this.validator,
      this.sufixIcon,
      this.textInputAction,
      this.textInputType,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    //custom textformwidget used for login screen with Title and textfield

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: height * 0.01),
      Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      SizedBox(height: height * 0.005),
      TextFormField(
          validator: validator,
          obscureText: obscure,
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          decoration: InputDecoration(
              prefixIcon: Icon(prefixIcon, color: AppColors.greyColor),
              suffixIcon: sufixIcon,
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.greyColor),
              filled: true,
              fillColor: AppColors.primaryBackgroundColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)))
    ]);
  }
}
