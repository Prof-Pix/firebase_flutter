import 'package:flutter/material.dart';

class CustomTextFieldLarge extends StatefulWidget {
  final String _labelText;
  final String _hintText;
  final TextEditingController _controller;
  final IconData? _prefixIcon;

  //for height and width
  final double _horizontalHeight;
  final double _verticalHeight;

  const CustomTextFieldLarge({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required double verticalHeight,
    required double horizontalHeight,
    IconData? prefixIcon,
    Key? key,
  })  : _labelText = labelText,
        _hintText = hintText,
        _controller = controller,
        _prefixIcon = prefixIcon,
        _horizontalHeight = horizontalHeight,
        _verticalHeight = verticalHeight,
        super(key: key);

  @override
  State<CustomTextFieldLarge> createState() => _CustomTextFieldLargeState();
}

class _CustomTextFieldLargeState extends State<CustomTextFieldLarge> {
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
          minLines: 5,
          maxLines: 5,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            filled: true,
            fillColor: const Color(0xffe6e1e1),
            hintText: widget._hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
