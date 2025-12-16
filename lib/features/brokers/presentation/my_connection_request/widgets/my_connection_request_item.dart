import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/presentation/connection_request/widgets/connection_request_option.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/enums/communication_type.dart';
import 'package:waseet/res/enums/tahalf_purpose_type.dart';
import 'package:waseet/res/res.dart';

class ConnectionRequestItem extends StatelessWidget {
  const ConnectionRequestItem({
    super.key,
    required this.connectionRequest,
    required this.onFavTap,
    this.onCallTap,
  });

  final ConnectionRequestEntity connectionRequest;
  final void Function(int) onFavTap;
  final Function? onCallTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
            left: 10,
            right: 10,
          ).r,
          padding: const EdgeInsets.all(15).r,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(101, 115, 50, 255),
                blurRadius: 4,
                offset: Offset(0, 1.68),
              ),
            ],
            border: Border(
              right: BorderSide(
                width: 20.w,
                color: AppColors.primaryColor,
              ),
            ),
            borderRadius: BorderRadius.circular(16).r,
            color: Colors.white,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RequestTextRow(
                lable: ' نوع العقار : ',
                image: Assets.icons.apartment.path,
                value: connectionRequest.category.name ?? '',
              ),
              SizedBox(
                height: 10.h,
              ),
              RequestTextRow(
                lable: 'المدينة : ',
                image: Constants.location,
                value: connectionRequest.city.name,
              ),
              SizedBox(
                height: 10.h,
              ),
              RequestTextRow(
                lable: 'الغرض : ',
                image: Assets.icons.questionSquare.path,
                value: connectionRequest.purpose == TahalfPurposeType.rent.name
                    ? TahalfPurposeType.rent.arabicName
                    : TahalfPurposeType.sale.arabicName,
              ),
              SizedBox(
                height: 10.h,
              ),
              RequestTextRow(
                lable: 'الوصف : ',
                image: Assets.icons.paperDetails.path,
                value: connectionRequest.description,
              ),
              SizedBox(
                height: 10.h,
              ),
              RequestTextRow(
                lable: 'طريقة التواصل : ',
                image: Assets.icons.contactWithUs.path,
                value: connectionRequest.communicationMethod ==
                        CommunicationMethod.whats.name
                    ? CommunicationMethod.whats.arabicName
                    : connectionRequest.communicationMethod ==
                            CommunicationMethod.call.name
                        ? CommunicationMethod.call.arabicName
                        : CommunicationMethod.message.arabicName,
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          child: ConnectionRequestOption(
            name: connectionRequest.createdBy.name ?? '',
            number: connectionRequest.createdBy.phone ?? '',
            image: connectionRequest.createdBy.profileImage,
            connectionRequest: connectionRequest,
            onFavTap: onFavTap,
            onCallTap: onCallTap,
          ),
        ),
      ],
    );
  }
}

class RequestTextRow extends StatefulWidget {
  const RequestTextRow({
    super.key,
    required this.lable,
    required this.image,
    required this.value,
  });
  final String lable;
  final String image;
  final String value;

  @override
  State<RequestTextRow> createState() => _RequestTextRowState();
}

class _RequestTextRowState extends State<RequestTextRow> {
  bool _expanded = false;
  bool _isOverflow = false;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      color: Constants.textColor,
      fontWeight: FontWeight.bold,
      fontSize: 12.sp,
    );
    final valueStyle = TextStyle(
      color: Constants.textColor,
      fontSize: 14.sp,
    );

    return LayoutBuilder(builder: (context, constraints) {
      // approximate reserved width for icon and spacing
      final iconBoxWidth = (8.r * 2) + 20.w; // padding + icon
      final spacing = 5.w;

      // measure label width
      final labelPainter = TextPainter(
        text: TextSpan(text: widget.lable, style: labelStyle),
        textDirection: TextDirection.rtl,
        maxLines: 1,
      )..layout();
      final labelWidth = labelPainter.width;

      final availableWidth = (constraints.maxWidth - iconBoxWidth - spacing - labelWidth - 8).clamp(0.0, constraints.maxWidth);

      final valueTp = TextPainter(
        text: TextSpan(text: widget.value, style: valueStyle),
        textDirection: TextDirection.rtl,
        maxLines: 3,
        ellipsis: '...',
      )..layout(maxWidth: availableWidth);

      _isOverflow = valueTp.didExceedMaxLines;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(
                      8,
                    ).r,
                  ),
                  color: Constants.secondaryColor.withOpacity(0.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(
                    8,
                  ).r,
                  child: SvgPicture.asset(
                    widget.image,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                widget.lable,
                style: labelStyle,
              ),
              Expanded(
                child: Text(
                  widget.value,
                  maxLines: _expanded ? null : 3,
                  overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: valueStyle,
                ),
              ),
            ],
          ),
          if (_isOverflow)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _toggle,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    _expanded ? 'عرض أقل' : 'عرض المزيد',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
