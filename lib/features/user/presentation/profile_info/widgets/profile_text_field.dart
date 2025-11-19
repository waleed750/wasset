// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  const ProfileTextField({
    super.key,
    this.text,
    this.initialValue,
    this.onChanged,
    this.focusNode,
    this.hintText,
    this.keyboardType,
    this.maxLines = 1,
    this.controller,
    this.enabled = true,
  });

  final String? text;
  final String? initialValue;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? hintText;
  final TextInputType? keyboardType;
  final int maxLines;
  final TextEditingController? controller;
  final bool enabled ;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);

    _controller.addListener(() {
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Color(0xFFC4C4C4),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.text != null)
          Text(
            widget.text!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onTapOutside: (s) {
            FocusScope.of(context).unfocus();
          },
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          controller: _controller,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 15,
            ),
            enabledBorder: borderDecoration,
            focusedBorder: borderDecoration,
            border: borderDecoration,
          ),
        ),
      ],
    );
  }
}
