import 'package:flutter/material.dart';
import 'package:waseet/res/res.dart';

class ProgressIndicatorSection extends StatelessWidget {
  const ProgressIndicatorSection({
    super.key,
    required this.progress,
  });

  final double progress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${progress.toInt()}%',
            style: const TextStyle(
              color: Color(0xFF262626),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress / 100,
          minHeight: 8,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            progress == 100 ? Colors.green : AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(64),
        ),
      ],
    );
  }
}
