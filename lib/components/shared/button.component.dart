import 'package:flutter/material.dart';

const double baseSize = 60;
const double growFactor = 4;

class ButtonComponent extends StatefulWidget {
  const ButtonComponent({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.duration,
    this.borderRadius,
    this.disabled,
    this.shouldAnimate,
  });

  final VoidCallback onPressed;
  final Widget child;

  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final int? duration;
  final double? borderRadius;

  final bool? disabled;
  final bool? shouldAnimate;

  @override
  State<ButtonComponent> createState() => _ButtonComponentState();
}

class _ButtonComponentState extends State<ButtonComponent> {
  @override
  void initState() {
    super.initState();

    width = widget.width;
    height = widget.height;
  }

  bool pressed = false;

  double? width;
  double? height;

  onDown() {
    setState(() {
      pressed = true;

      if (widget.shouldAnimate != false) {
        width = (widget.width ?? baseSize) + growFactor;
        height = (widget.height ?? baseSize) + growFactor;
      }
    });
  }

  onUp() {
    setState(() {
      pressed = false;

      if (widget.shouldAnimate != false) {
        width = (widget.width ?? baseSize);
        height = (widget.height ?? baseSize);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: GestureDetector(
        onTapDown: widget.disabled != true
            ? (data) => {
                  onDown(),
                }
            : null,
        onTap: widget.disabled != true
            ? () => {
                  onUp(),
                  widget.onPressed(),
                }
            : null,
        child: Opacity(
          opacity: widget.disabled == true ? 0.7 : 1,
          child: AnimatedContainer(
            width: width,
            height: height,
            padding: widget.padding,
            curve: Curves.bounceOut,
            duration: Duration(milliseconds: widget.duration ?? 25),
            margin: pressed && widget.shouldAnimate != false
                ? EdgeInsets.all(0)
                : EdgeInsets.all(growFactor / 2),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.all(
                Radius.circular(widget.borderRadius ?? 12),
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
