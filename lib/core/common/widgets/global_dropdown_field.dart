import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/common/styles/global_text_style.dart';
import 'package:siam_portfolio/core/utils/constants/colors.dart';

class GlobalDropdownField extends StatelessWidget {
  const GlobalDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final String hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.containerColor071229,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor3B4861),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.containerColor060E20,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textGreyColorB5BEC7,
            size: 20,
          ),
          hint: Text(
            hintText,
            style: getTextStyle(
              color: AppColors.textGreyColorB5BEC7,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              lineHeight: 10,
            ),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: getTextStyle(
                      color: AppColors.textGreyColorE7E8EB,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      lineHeight: 10,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
