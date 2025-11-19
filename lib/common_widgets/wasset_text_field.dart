import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/res/res.dart';

class WassetTextField extends StatefulWidget {
  const WassetTextField({
    super.key,
    this.title,
    this.hintText,
    this.errorText,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.onChanged,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.isRtl = true,
    this.value,
    this.initialValue,
    this.controller,
  });

  final String? title;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final void Function(String)? onChanged;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isRtl;
  final String? value;
  final String? initialValue;
  final TextEditingController? controller;
  @override
  State<WassetTextField> createState() => _WassetTextFieldState();
}

class _WassetTextFieldState extends State<WassetTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.value)
      ..addListener(() {
        widget.onChanged?.call(_controller.text);
      });
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Directionality(
            textDirection: widget.isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: TextFormField(
              onTapOutside: (c) {
                FocusScope.of(context).unfocus();
              },
              initialValue: widget.initialValue,
              maxLines: widget.maxLines,
              cursorColor: AppColors.primaryColor,
              keyboardType: widget.keyboardType,
              controller: _controller,
              obscureText: widget.isPassword && _obscureText,
              decoration: InputDecoration(
                errorText: widget.errorText,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFCFD2D4),
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.isPassword
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.primaryColor,
                          size: 17,
                        ),
                      )
                    : widget.suffixIcon,
                hintText: widget.hintText,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ).r,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(10).r,
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(10).r,
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.textFieldBorderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(10).r,
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                errorBorder: widget.errorText != null
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10).r,
                        ),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
