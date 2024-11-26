import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String text;
  final Future<void> Function() onPressed;
  final Color color;
  final Color textColor;

  const LoadingButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.red,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;

  void _handlePress() async {
    setState(() {
      isLoading = true;
    });
    await widget.onPressed();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: isLoading ? null : _handlePress,
      child: isLoading
          ? CircularProgressIndicator(
              color: widget.textColor,
            )
          : Text(
              widget.text,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
