import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textfieldcheck({
  TextEditingController? controller,
  required String name,
  TextInputType? inputtype,
  double? width,
  bool? isread,
  int? maxline,
  String? value,
  List<TextInputFormatter>? inputFormatters,
  dynamic prefixIcon,
  dynamic suffixIcon,
  String? fieldtype,
  Function(String)? onChanged,
  bool? obscureText,
}) {
  return Container(
    width: width,
    child: TextFormField(
      obscureText: obscureText ?? false,
      keyboardType: inputtype ?? TextInputType.text,
      initialValue: value,
      readOnly: isread ?? false,
      maxLines: maxline ?? 1,
      onChanged: onChanged ?? (value) {},
      // style: TextStyle(
      //     ),
      inputFormatters: inputFormatters ??
          <TextInputFormatter>[
            FilteringTextInputFormatter.singleLineFormatter,
          ],
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        } else {
          return null;
        }
      },
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: name,
        alignLabelWithHint: true,
        fillColor: Colors.white,
        filled: true,
        errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue)),
      ),
    ),
  );
}

Widget textfieldcheckNoValid({
  TextEditingController? controller,
  required String name,
  TextInputType? inputtype,
  double? width,
  bool? isread,
  int? maxline,
  String? value,
  List<TextInputFormatter>? inputFormatters,
  dynamic prefixIcon,
  dynamic suffixIcon,
  String? fieldtype,
  Function(String)? onChanged,
  bool? obscureText,
}) {
  return Container(
    width: width,
    child: TextFormField(
      obscureText: obscureText ?? false,
      keyboardType: inputtype ?? TextInputType.text,
      initialValue: value,
      readOnly: isread ?? false,
      maxLines: maxline ?? 1,
      onChanged: onChanged ?? (value) {},
      // style: TextStyle(
      //     ),
      inputFormatters: inputFormatters ??
          <TextInputFormatter>[
            FilteringTextInputFormatter.singleLineFormatter,
          ],
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: name,
        alignLabelWithHint: true,
        fillColor: Colors.white,
        filled: true,
        errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue)),
        enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue)),
      ),
    ),
  );
}
