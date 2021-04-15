library loading_button;
import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String buttonTitle;
  final double buttonHeight;
  final double buttonWidth;
  final Function() onPress;
  final TextStyle? buttonTextStyle;
  final Duration? animationDuration;
  final Color? buttonColor;
  final double? buttonCorner;
  final double? loaderSize;
  final EdgeInsets? margin;

  const LoadingButton(
      {Key? key,
        required this.buttonTitle,
        required this.buttonHeight,
        required this.buttonWidth,
        required this.onPress,
        this.buttonTextStyle,
        this.animationDuration,
        this.buttonColor,
        this.buttonCorner,
        this.loaderSize,
        this.margin})
      : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _loading = false;

  void toggleLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: AnimatedOpacity(
            duration: widget.animationDuration ?? Duration(milliseconds: 500),
            opacity: _loading ? 1 : 0,
            child: Center(
              child: Container(
                margin: widget.margin ?? EdgeInsets.all(0),
                height: widget.loaderSize ?? 30,
                width: widget.loaderSize ?? 30,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
        Center(
          child: AnimatedContainer(
            margin: widget.margin ?? EdgeInsets.all(0),
            duration: widget.animationDuration ?? Duration(milliseconds: 500),
            height: _loading ? 0 : widget.buttonHeight,
            width: _loading ? 0 : widget.buttonWidth,
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  toggleLoading();
                  await widget.onPress();
                  toggleLoading();
                },
                style: ElevatedButton.styleFrom(
                  primary: widget.buttonColor ?? Theme.of(context).primaryColor,
                  onPrimary: widget.buttonColor ?? Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(widget.buttonCorner ?? 0.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.buttonTitle,
                    style: widget.buttonTextStyle ??
                        TextStyle(
                          fontFamily: 'Robot',
                          fontSize: 15,
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                        ),
                    textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

