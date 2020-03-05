import 'package:flutter/material.dart';

import 'utils.dart';

class WebHtmlView extends StatefulWidget {
  const WebHtmlView({
    @required this.src,
    this.key = const ValueKey('web-content'),
    this.height,
    this.width,
    this.webAllowFullScreen = true,
  }) : super(key: key);

  @override
  _WebHtmlViewState createState() => _WebHtmlViewState();

  final num height;
  final String src;
  final num width;
  final bool webAllowFullScreen;
  final ValueKey<String> key;
}

class _WebHtmlViewState extends State<WebHtmlView> {
  @override
  Widget build(BuildContext context) {
    return OptionalSizedChild(
      width: widget?.width,
      height: widget?.height,
      builder: (w, h) => Placeholder(),
    );
  }
}
