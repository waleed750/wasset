// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final bool enabled;

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
          inputFormatters: [
            PhoneMaskingDescriptionFormatter(),
          ],
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

/// Formatter that detects phone-like numbers in Arabic/English text
/// and masks them completely with #
/// - Supports Saudi patterns: 05xxxxxxxx / +9665xxxxxxxx
/// - Supports any long digit sequence (>=7)
/// - Works with Western digits (0-9) and Arabic-Indic digits (٠١٢٣٤٥٦٧٨٩)
class PhoneMaskingDescriptionFormatter extends TextInputFormatter {
  /// اختياري: نحتفظ بآخر رقم حقيقي تم اكتشافه (بدون ماسك)
  String? lastDetectedPhone;

  // Digit class: 0-9 and Arabic-Indic ٠-٩
  static const String _digitClass = r'0-9\u0660-\u0669';

  // Regex:
  // - +9665 + 8 digits
  // - 05 + 8 digits
  // - any sequence of 7+ digits (عربي أو إنجليزي)
  final RegExp phoneRegex = RegExp(
    r'(\+966[0-9\u0660-\u0669]{8}|0[5\u0665][0-9\u0660-\u0669]{8}|[0-9\u0660-\u0669]{7,})',
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    final matches = phoneRegex.allMatches(text);
    if (matches.isEmpty) {
      // مفيش أرقام شبه تليفون → نسيب النص زي ما هو
      return newValue;
    }

    // نستبدل كل رقم تليفون بسلسلة # بنفس الطول
    String masked = text.replaceAllMapped(phoneRegex, (match) {
      final phone = match.group(0)!;
      lastDetectedPhone = phone; // حفظ آخر رقم لو حابب تستخدمه

      return "#" * phone.length;
    });

    return TextEditingValue(
      text: masked,
      selection: TextSelection.collapsed(offset: masked.length),
    );
  }
}
