import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onTextChange;
  final Stream<String> stream;

  const CustomInputField(
      {Key? key,
      required this.hintText,
      required this.onTextChange,
      required this.stream})
      : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<String>(
          stream: widget.stream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: widget.onTextChange,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  errorText: snapshot.hasError?snapshot.error.toString():null),
            );
          }),
    );
  }
}
