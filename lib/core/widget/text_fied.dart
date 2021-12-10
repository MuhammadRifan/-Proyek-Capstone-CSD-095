import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class FieldInput extends StatelessWidget {
  const FieldInput({
    Key? key,
    required this.hint,
    this.controller,
    this.focusNode,
    this.validateMode,
    this.validator,
    this.onSubmitted,
    this.maxLength,
    this.canNext = false,
    this.numberKeyboard = false,
    this.numberInput = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final AutovalidateMode? validateMode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final String hint;
  final int? maxLength;
  final bool canNext;
  final bool numberKeyboard;
  final bool numberInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autovalidateMode: validateMode ?? AutovalidateMode.onUserInteraction,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: hint,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
      ),
      keyboardType:
          (numberKeyboard || numberInput) ? TextInputType.number : null,
      inputFormatters: (numberInput)
          ? [
              FilteringTextInputFormatter.digitsOnly,
            ]
          : null,
      onFieldSubmitted: onSubmitted,
      textInputAction: (canNext) ? TextInputAction.next : null,
      validator: validator,
    );
  }
}

class FieldSearch extends StatefulWidget {
  const FieldSearch({
    Key? key,
    required this.ctrl,
    required this.focusNode,
    required this.onSubmitted,
  }) : super(key: key);

  final TextEditingController ctrl;
  final FocusNode focusNode;
  final ValueChanged<String> onSubmitted;

  @override
  _FieldSearchState createState() => _FieldSearchState();
}

class _FieldSearchState extends State<FieldSearch> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.ctrl,
      focusNode: widget.focusNode,
      style: TextStyle(
        color: Colors.grey.shade700,
      ),
      decoration: InputDecoration(
        hintText: "Search",
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Colors.grey,
        ),
        suffixIcon: (widget.ctrl.text.isNotEmpty)
            ? GestureDetector(
                onTap: () {
                  setState(
                    () => widget.ctrl.text = "",
                  );
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.zero,
      ),
      onSubmitted: widget.onSubmitted,
      onChanged: (str) => setState(() {}),
    );
  }
}
