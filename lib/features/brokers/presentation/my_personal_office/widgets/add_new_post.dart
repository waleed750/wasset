// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/profile_text_field.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/res.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({
    super.key,
    this.onAddNewPost,
    this.content,
  });

  final void Function(String)? onAddNewPost;
  final String? content;

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentController.text = widget.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8).r,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.5),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: (MediaQuery.of(context).size.width * 0.9).w,
        padding: const EdgeInsets.all(16).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Align(
                    child: Text(
                      'اضافة محتوى',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            ProfileTextField(
              controller: _contentController,
              maxLines: 5,
              hintText: 'اكتب وأثرينا بالمحتوى الذهبي',
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: WassetButton(
                text: 'نشر',
                onTap: () {
                  widget.onAddNewPost?.call(_contentController.text);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
