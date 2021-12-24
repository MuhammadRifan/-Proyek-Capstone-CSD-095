import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final AutovalidateMode? validateMode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final String hint;
  final int? maxLength;
  final int maxLines;
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
      maxLines: maxLines,
      minLines: 1,
      // expands: (maxLines > 1) ? true : false,
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
      textInputAction: (canNext) ? TextInputAction.next : TextInputAction.done,
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
      textInputAction: TextInputAction.search,
      onSubmitted: widget.onSubmitted,
      onChanged: (str) => setState(() {}),
    );
  }
}

// ignore: must_be_immutable
class FieldDateTime extends StatelessWidget {
  FieldDateTime({
    Key? key,
    required this.ctrlText,
    required this.onSaved,
    this.focusNode,
    this.nextFocus,
    this.disableBackDate = false,
    this.isReadOnly = false,
    this.timeInput = false,
    this.borderOutline = true,
    this.hint,
    this.dateFormat,
    this.timeFormat,
  }) : super(key: key);

  final TextEditingController ctrlText;
  final Function(String?)? onSaved;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool disableBackDate;
  final bool isReadOnly;
  final bool timeInput;
  final bool borderOutline;
  final String? dateFormat;
  final String? timeFormat;
  final String? hint;

  final DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: disableBackDate ? currentDate : DateTime(1970),
      lastDate: DateTime(currentDate.year + 20),
    );

    if (picked != null) {
      ctrlText.text = DateFormat(dateFormat ?? "yyyy-MM-dd").format(picked);
      if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      currentTime = picked;
      // log(currentTime.format(context));
      // DateTime pickedTimeFormat = DateFormat.jm().parse(picked.format(context));
      // ctrlText.text = DateFormat("HH:mm").format(pickedTimeFormat);
      ctrlText.text = picked.format(context);
      if (nextFocus != null) FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: ctrlText,
      decoration: InputDecoration(
        border: borderOutline ? const OutlineInputBorder() : null,
        hintText: (borderOutline)
            ? (hint != null)
                ? hint
                : (dateFormat != null)
                    ? dateFormat
                    : (timeFormat != null)
                        ? timeFormat
                        : (timeInput)
                            ? "HH:mm"
                            : "YYYY-MM-DD"
            : null,
        labelText: (!borderOutline)
            ? (hint != null)
                ? hint
                : (dateFormat != null)
                    ? dateFormat
                    : (timeFormat != null)
                        ? timeFormat
                        : (timeInput)
                            ? "HH:mm"
                            : "YYYY-MM-DD"
            : null,
        contentPadding: (!borderOutline)
            ? const EdgeInsets.symmetric(
                vertical: 10,
              )
            : null,
        suffixIcon: Icon(
          (timeInput) ? Icons.access_time : Icons.date_range,
          color: Colors.grey,
        ),
      ),
      onTap: () => !isReadOnly
          ? timeInput
              ? _selectTime(context)
              : _selectDate(context)
          : null,
      onSaved: onSaved,
      focusNode: focusNode,
    );
  }
}
