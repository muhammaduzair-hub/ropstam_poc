import 'package:flutter/material.dart';

import '../../viewmodels/widgets/custom_text_field_model.dart';
import '../views/base_widget.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool showPassword;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final Function? onSubmit;
  final TextInputAction? inputAction;
  final bool readOnly;

  CustomTextField(
      {this.controller,
      this.showPassword = false,
      this.minLines,
      this.maxLines,
      this.keyboardType = TextInputType.text,
      this.onSubmit,
      this.readOnly = false,
      this.inputAction,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 44,
      child: showPassword
          ? BaseWidget<CustomTextFieldViewModel>(
              model: CustomTextFieldViewModel(),
              builder: (context, model, child) => TextField(
                  maxLength: maxLength,
                  readOnly: readOnly,
                  onSubmitted: (value) => onSubmit,
                  keyboardType: keyboardType,
                  obscureText: model.obscureText,
                  textInputAction: inputAction ?? TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xffD5DDE0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xffD5DDE0)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        model.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 19,
                      ),
                      onPressed: () {
                        model.switchState();
                      },
                    ),
                    fillColor: Colors.grey
                        .shade100, //Color(0xffF7F8F9),//Colors.grey.shade200,
                    filled: true,
                  ),
                  controller: controller),
            )
          : TextField(
              maxLength: maxLength,
              keyboardType: keyboardType,
              readOnly: readOnly,
              textInputAction: inputAction ?? TextInputAction.next,
              onSubmitted: (value) => onSubmit,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 10,
                  bottom: 0.5,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xffD5DDE0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xffD5DDE0)),
                ),
                fillColor: Colors
                    .grey.shade100, //Color(0xffF7F8F9),//Colors.grey.shade200,
                filled: true,
              ),
              minLines: minLines ?? 1, //Normal textInputField will be displayed
              maxLines:
                  maxLines ?? 1, // when user presses enter it will adapt to it
              controller: controller),
    );
  }
}
