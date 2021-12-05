import 'package:flutter/material.dart';

class FieldAuth extends StatefulWidget {
  const FieldAuth({
    Key? key,
    this.controller,
    this.focusNode,
    this.validateMode,
    this.validator,
    this.onSubmitted,
    this.canNext = false,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final AutovalidateMode? validateMode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final bool canNext;
  final bool isPassword;

  @override
  _FieldAuthState createState() => _FieldAuthState();
}

class _FieldAuthState extends State<FieldAuth> {
  bool _showPass = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: (widget.isPassword) ? !_showPass : false,
      autovalidateMode:
          widget.validateMode ?? AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Color(0xFF908E8E),
          ),
        ),
        isCollapsed: true,
        contentPadding: const EdgeInsets.all(15),
        suffixIcon: (widget.isPassword)
            ? IconButton(
                icon: Icon(
                  _showPass
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
                onPressed: () {
                  setState(
                    () => _showPass = !_showPass,
                  );
                },
              )
            : null,
      ),
      onFieldSubmitted: widget.onSubmitted,
      textInputAction: (widget.canNext) ? TextInputAction.next : null,
      validator: widget.validator,
    );
  }
}
