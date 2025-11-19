import 'package:flutter/material.dart';
import 'package:waseet/res/res.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.controller,
  });
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: _controller,
        onChanged: widget.onChanged,
        onTapOutside: (_) {
          FocusScope.of(context).unfocus();
        },
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 2),
          hintText: widget.hintText ?? '',
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          filled: true,
          fillColor: const Color(0xFFF1F2F3),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 5,
              color: Color(0xFFF1F2F3),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
