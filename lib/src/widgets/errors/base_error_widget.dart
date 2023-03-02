import 'package:flutter/material.dart';


class BaseErrorWidget extends StatefulWidget {
  final GestureTapCallback ?onTap;
  final String? title;
  final String? subtitle;
  final Widget? icon;
  final Widget? button;

  const BaseErrorWidget({
    Key? key,
    this.onTap,
    this.title,
    this.subtitle,
    this.icon,
    this.button,
  }) : super(key: key);

  @override
  State<BaseErrorWidget> createState() => _BaseErrorWidgetState();
}

class _BaseErrorWidgetState extends State<BaseErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(

        child: InkWell(

          onTap: widget.onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: widget.icon,
              ),

              Text(
                "${widget.title}",
                //widget.title ?? '',
                style: const TextStyle(
                  fontSize: 20,

                ),
                textAlign: TextAlign.center,
                //       )AppTheme.headline3
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.subtitle ?? "press to retry",
                style: const TextStyle(

                  fontSize: 20,
                ),
                //AppTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              widget.button??Container()
            ],
          ),
        ),
      ),
    );
  }
}
