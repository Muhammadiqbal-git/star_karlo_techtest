import 'package:flutter/material.dart';
import 'package:test_starkarlo/utils/app_color.dart';
import 'package:test_starkarlo/utils/helper.dart';

class CustomTextField extends StatefulWidget {
  final double? height;
  final double? width;
  final String? text;
  final TextStyle? textStyle;
  final String? hint;
  final TextStyle? hintStyle;
  final Function(String value)? onTap;
  final EdgeInsets? padding;
  final Function(String value)? onChange;
  final bool? focus;
  final String? initText;

  const CustomTextField({
    super.key,
    this.height,
    this.width,
    this.text,
    this.textStyle,
    this.hint,
    this.hintStyle,
    this.onTap,
    this.onChange,
    this.padding,
    this.focus,
    this.initText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.initText);
    _focusNode = FocusNode();

    if (widget.focus == true) {
      print("trueeeeee");
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _focusNode.requestFocus();
      });
    }
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
    return ConstrainedBox(
      constraints:
          BoxConstraints(minWidth: 100, maxWidth: getWidth(context, 100)),
      child: Container(
        height: widget.height ?? 40,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.primaryGreen, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _textEditingController,
                focusNode: _focusNode,
                onChanged: (value) {
                  widget.onChange?.call(value);
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: widget.hint,
                    hintStyle: widget.hintStyle,
                    isCollapsed: true,
                    border: InputBorder.none),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _focusNode.unfocus();
                  widget.onTap?.call(_textEditingController.text);
                },
                splashColor: AppColor.primaryGreen.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8)),
                child: Ink(
                  height: widget.height ?? 40,
                  width: widget.width,
                  padding: widget.padding ??
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.primaryGreen,
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.text ?? "",
                        style: widget.textStyle,
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
