import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoadingButton extends StatefulWidget {
  final String text;
  final Function() onPressed;
  final bool? isLoading; // Made optional
  final Color? backgroundColor;
  final double borderRadius;
  final EdgeInsets padding;
  final Icon? rightIcon;
  final bool isOutlined; // New parameter for outline variant
  final Color? foregroundColor; // New parameter for text/icon color

  const CustomLoadingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading, // Now optional
    this.backgroundColor,
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.all(16.0),
    this.rightIcon,
    this.isOutlined = false,
    this.foregroundColor,
  });

  @override
  State<CustomLoadingButton> createState() => _CustomLoadingButtonState();
}

class _CustomLoadingButtonState extends State<CustomLoadingButton> {
  bool _internalLoading = false;

  // Getter to determine if button should show loading state
  bool get _isLoading => widget.isLoading ?? _internalLoading;

  // Handle the button press with automatic loading state
  Future<void> _handlePress() async {
    if (_isLoading) return; // Prevent multiple presses while loading

    // If it's not an async function, just call it and return
    if (widget.onPressed is! Future Function()) {
      widget.onPressed();
      return;
    }

    try {
      setState(() => _internalLoading = true);
      await widget.onPressed();
    } finally {
      if (mounted) {
        setState(() => _internalLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handlePress,
      style: ElevatedButton.styleFrom(
        padding: widget.padding,
        backgroundColor: widget.isOutlined
            ? Colors.transparent
            : (widget.backgroundColor ?? Theme.of(context).colorScheme.primary),
        foregroundColor: widget.foregroundColor ??
            (widget.isOutlined
                ? (widget.backgroundColor ??
                    Theme.of(context).colorScheme.primary)
                : Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          side: widget.isOutlined
              ? BorderSide(
                  color: widget.backgroundColor ??
                      Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              : BorderSide.none,
        ),
        disabledBackgroundColor: widget.isOutlined
            ? Colors.transparent
            : (widget.backgroundColor ?? Theme.of(context).colorScheme.primary),
        elevation: widget.isOutlined ? 0 : null,
      ),
      child: _isLoading
          ? CupertinoActivityIndicator(
              color: widget.isOutlined
                  ? (widget.backgroundColor ??
                      Theme.of(context).colorScheme.primary)
                  : Colors.white,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.foregroundColor ??
                        (widget.isOutlined
                            ? (widget.backgroundColor ??
                                Theme.of(context).colorScheme.primary)
                            : Colors.white),
                  ),
                ),
                if (widget.rightIcon != null) ...[
                  const SizedBox(width: 4),
                  widget.rightIcon!,
                ],
              ],
            ),
    );
  }
}
