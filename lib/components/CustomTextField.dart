import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatefulWidget {
  final String _labelText;
  final String _hintText;
  final TextEditingController _controller;
  final IconData _prefixIcon;
  final RegExp? _regex;

  const CustomTextField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required IconData prefixIcon,
    RegExp? regex,
    Key? key,
  })  : _labelText = labelText,
        _hintText = hintText,
        _controller = controller,
        _prefixIcon = prefixIcon,
        _regex = regex,
        super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget._labelText,
          style: const TextStyle(
              fontSize: 16, letterSpacing: 0.5, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 2,
        ),
        TextFormField(
          controller: widget._controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              setState(() {
                _isEmpty = value?.isEmpty ?? true;
              });
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  _isEmpty = false;
                });
              });
              return "This field is required";
            } else if (widget._regex != null && value.isNotEmpty) {
              if (!widget._regex!.hasMatch(value)) {
                return "Please enter a valid email";
              }
            }

            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffe6e1e1),
            hintText: widget._hintText,
            hintStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w300),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: _isEmpty ? Colors.red : Colors.transparent,
                    width: 1.2)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            contentPadding: const EdgeInsets.all(10),
            prefixIcon: Icon(
              widget._prefixIcon,
              color: const Color(0xffffffff),
            ),
          ),
        ),
      ],
    );
  }
}
