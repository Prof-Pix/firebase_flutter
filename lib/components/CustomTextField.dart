import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String _labelText;
  final String _hintText;
  final TextEditingController _controller;
  final IconData _prefixIcon;

  const CustomTextField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required IconData prefixIcon,
    IconData? suffixIcon,
    Key? key,
  })  : _labelText = labelText,
        _hintText = hintText,
        _controller = controller,
        _prefixIcon = prefixIcon,
        super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget._labelText,
          style: const TextStyle(fontSize: 16, letterSpacing: 0.5),
        ),
        const SizedBox(
          height: 2,
        ),
        TextFormField(
          controller: widget._controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffe6e1e1),
            hintText: widget._hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide.none,
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
