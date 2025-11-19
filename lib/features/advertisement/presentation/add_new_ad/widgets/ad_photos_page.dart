// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/res.dart';

class AdPhotosPage extends StatelessWidget {
  const AdPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAdCubit, AddNewAdState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'فيديو وصور للعقار',
                style: TextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16).r,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8).r,
                  border: Border.all(color: Colors.grey.shade300, width: 2.w),
                ),
                child: DottedBorder(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                  padding: EdgeInsets.all(16).r,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(8).r,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Assets.images.uploadImage.svg(
                          width: 80.w,
                          height: 80.h,
                          // color: AppColors.primaryColor,
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width * 0.4).w,
                          child: WassetButton(
                            text: 'رفع',
                            onTap: () async {
                              final source =
                                  await showModalBottomSheet<ImageSource>(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (context) {
                                  return SafeArea(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 8,
                                      ).r,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            tileColor: Color(0xFFF3F6FD),
                                            leading: Assets.icons.camera.svg(
                                              width: 24.w,
                                              height: 24.h,
                                            ),
                                            title: Text('الكاميرا'),
                                            onTap: () {
                                              Navigator.pop(
                                                context,
                                                ImageSource.camera,
                                              );
                                            },
                                          ),
                                          SizedBox(height: 8.h),
                                          ListTile(
                                            tileColor: Color(0xFFF3F6FD),
                                            leading: Assets.icons.gallery.svg(
                                              width: 24.w,
                                              height: 24.h,
                                            ),
                                            title: Text('المعرض'),
                                            onTap: () {
                                              Navigator.pop(
                                                context,
                                                ImageSource.gallery,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              if (source == null) return;
                              File? file;
                              if (source == ImageSource.camera) {
                                final image = await ImagePicker.platform
                                    .getImageFromSource(
                                  source: source,
                                );
                                if (image == null) return;
                                file = File(image.path);
                              } else {
                                final image =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.media,
                                );
                                if (image == null) return;
                                file = File(image.files.single.path!);
                              }
                              context.read<AddNewAdCubit>().addImage(
                                    file,
                                  );
                            },
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'إضافة صورة أو فيديو',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              ...List.generate(
                state.addAdRequest.images.length,
                (index) {
                  final media = state.addAdRequest.images[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16).r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8).r,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 2.w),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: media.image,
                        ),
                        SizedBox(width: 16),
                        Text(
                          '${media.isVideo ? 'فيديو' : 'صورة'} ${index + 1}',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.read<AddNewAdCubit>().removeImage(index);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

extension FileTypes on File {
  Widget get image {
    final ext = path.split('.').last;
    if (ext == 'mp4') {
      return ColoredBox(
        color: Colors.black,
        child: Center(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 40.sp,
          ),
        ),
      );
    }
    return Image.file(
      this,
      height: 50,
      width: 50,
      fit: BoxFit.cover,
    );
  }

  bool get isVideo => path.split('.').last == 'mp4';
}
