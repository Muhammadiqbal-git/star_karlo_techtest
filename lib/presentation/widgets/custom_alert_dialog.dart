import 'package:flutter/material.dart';
import 'package:test_starkarlo/presentation/widgets/custom_button.dart';
import 'package:test_starkarlo/utils/app_color.dart';
import 'package:test_starkarlo/utils/text_style.dart';

class CustomAlertDialog extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final String desc;
  final TextStyle? descStyle;

  const CustomAlertDialog(
      {super.key,
      required this.text,
      required this.desc,
      this.textStyle,
      this.descStyle});

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.text,
        style: widget.textStyle,
      ),
      content: Text(
        widget.desc,
        style: widget.descStyle,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              text: "Okay",
              textStyle: appTextStyle.t14b.copyWith(color: AppColor.white),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
