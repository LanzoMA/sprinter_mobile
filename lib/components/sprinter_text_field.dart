import 'package:flutter/material.dart';

class SprinterTextField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData icon;
  final String? errorText;

  const SprinterTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    required this.icon,
    required this.errorText,
  });

  @override
  State<SprinterTextField> createState() => _SprinterTextFieldState();
}

class _SprinterTextFieldState extends State<SprinterTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  Widget? getSuffixIcon() {
    if (!widget.obscureText) {
      return null;
    }

    final IconData icon =
        _obscureText ? Icons.visibility : Icons.visibility_off;

    return InkWell(
      onTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon),
        hintText: widget.hintText,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 12.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).colorScheme.surface,
        errorText: widget.errorText,
        suffixIcon: getSuffixIcon(),
        suffixIconColor: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
