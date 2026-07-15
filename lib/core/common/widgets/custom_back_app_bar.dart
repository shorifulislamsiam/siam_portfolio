import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/common/styles/global_text_style.dart';
import 'package:siam_portfolio/core/utils/constants/colors.dart';

class CustomBackAppBar extends StatelessWidget {
  final String? text;
  const CustomBackAppBar({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 8.5),
      decoration: BoxDecoration(color: AppColors.containerColor1A1A2E),
      child: Row(
        children: [
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 25,
              color: AppColors.whiteColor,
            ),
          ),
          Text(
            text ?? "Back",
            style: getTextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              lineHeight: 10,
            ),
          ),
        ],
      ),
    );
  }
}
