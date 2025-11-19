import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/features/user/domain/entities/complaint_entity.dart';

class ComplaintCard extends StatefulWidget {
  const ComplaintCard({
    super.key,
    required this.complaint,
  });
  final ComplaintEntity complaint;

  @override
  State<ComplaintCard> createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ).r,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20).r,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(101, 115, 50, 255),
              blurRadius: 4,
              offset: Offset(0, 1.68),
            ),
          ],
          borderRadius: BorderRadius.circular(16).r,
          color: Colors.white,
        ),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'رقم البلاغ :  ${widget.complaint.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 20).r,
                  decoration: BoxDecoration(
                    color: widget.complaint.status! == 'processed'
                        ? const Color.fromARGB(73, 76, 175, 79)
                        : widget.complaint.status! == 'pending'
                            ? const Color.fromARGB(73, 255, 153, 0)
                            : const Color.fromARGB(73, 244, 67, 54),
                    borderRadius: BorderRadius.circular(8).r,
                  ),
                  child: Text(
                    widget.complaint.status! == 'processed'
                        ? 'تم معالجته'
                        : widget.complaint.status! == 'pending'
                            ? 'قيد المعالجة'
                            : 'مرفوض',
                    style: TextStyle(
                      color: widget.complaint.status! == 'processed'
                          ? Colors.green
                          : widget.complaint.status! == 'pending'
                              ? Colors.orange
                              : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            if (isOpen)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  '${widget.complaint.description}',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
