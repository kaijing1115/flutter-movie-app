import 'package:flutter/material.dart';
import '../autoload/autoloader.dart';

class IconBorderTextField extends StatefulWidget {
  const IconBorderTextField({
    super.key,
    this.icon,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.controller,
    this.clearable = false,
  });

  final IconData? icon;
  final String? hintText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool readOnly;
  final TextEditingController? controller;
  final bool clearable;

  @override
  State<IconBorderTextField> createState() => _IconBorderTextFieldState();
}

class _IconBorderTextFieldState extends State<IconBorderTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor.withOpacity(0.5),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.icon != null) Icon(widget.icon),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              readOnly: widget.readOnly,
              enabled: !widget.readOnly,
              style: const TextStyle(
                color: Color(0xff93B1A6),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: placeholderColor,
                ),
              ),
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
          if (widget.clearable)
            IconButton(
              icon: Icon(
                Icons.highlight_off,
                color: iconColor.withOpacity(0.7),
              ),
              onPressed: () {
                setState(() {
                  _controller.text = "";
                });
              },
            ),
        ],
      ),
    );
  }
}
