import 'package:flutter/material.dart';
import 'package:test_starkarlo/presentation/widgets/custom_button.dart';
import 'package:test_starkarlo/utils/app_color.dart';
import 'package:test_starkarlo/utils/text_style.dart';

class CustomTextFieldDialog extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Function(String) callback;
  const CustomTextFieldDialog(
      {super.key, required this.text, required this.callback, this.textStyle});

  @override
  State<CustomTextFieldDialog> createState() => _CustomTextFieldDialogState();
}

class _CustomTextFieldDialogState extends State<CustomTextFieldDialog> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.text,
        style: widget.textStyle,
      ),
      content: TextField(
        controller: _textEditingController,
        focusNode: _focusNode,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              text: "Cancel",
              textStyle: appTextStyle.t14b.copyWith(color: AppColor.white),
              onTap: () {
                _textEditingController.clear();
                Navigator.pop(context);
              },
            ),
            CustomButton(
              text: "Confirm",
              textStyle: appTextStyle.t14b.copyWith(color: AppColor.white),
              onTap: () {
                widget.callback(_textEditingController.text);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ],
    );
  }
}
