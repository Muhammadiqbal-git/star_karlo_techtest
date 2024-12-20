import 'package:flutter/material.dart';
import 'package:test_starkarlo/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String? text;
  final TextStyle? textStyle;
  final Function()? onTap;
  final EdgeInsets? padding;

  const CustomButton(
      {super.key,
      this.height,
      this.width,
      this.text,
      this.textStyle,
      this.onTap,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 35),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColor.primaryGreen.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          child: Ink(
            height: height ?? 40,
            width: width,
            padding:
                padding ?? EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: AppColor.primaryGreen,
                border: Border.all(color: AppColor.white, width: 2),
                borderRadius: BorderRadius.circular(8)),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  text ?? "",
                  style: textStyle,
                  textAlign: TextAlign.center,
                )),
          ),
        ),
      ),
    );
  }
}
