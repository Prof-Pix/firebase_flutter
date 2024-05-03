import 'package:flutter/material.dart';

class CustomTextPasswordField extends StatefulWidget {
  final String _labelText;
  final String _hintText;
  final TextEditingController _controller;

  const CustomTextPasswordField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    Key? key,
  })  : _labelText = labelText,
        _hintText = hintText,
        _controller = controller,
        super(key: key);

  @override
  State<CustomTextPasswordField> createState() =>
      _CustomTextPasswordFieldState();
}

class _CustomTextPasswordFieldState extends State<CustomTextPasswordField> {
  bool _isEmpty = false;

  //for setting the obscureText property
  bool hidePassword = true;
  void setHidePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

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
          obscureText: hidePassword,
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
              return 'This field is required';
            } else if (value.length < 8) {
              return "Password must be 8 characters long.";
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
              prefixIcon: const Icon(
                Icons.lock,
                color: Color(0xffffffff),
              ),
              suffixIcon: IconButton(
                icon: hidePassword
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: setHidePassword,
              )),
        ),
      ],
    );
  }
}
