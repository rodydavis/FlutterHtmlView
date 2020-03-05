import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html' as html;

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

  final ValueKey<String> key;
  final num height;
  final String src;
  final num width;
  final bool webAllowFullScreen;
}

class _WebHtmlViewState extends State<WebHtmlView> {
  @override
  void didUpdateWidget(WebHtmlView oldWidget) {
    if (oldWidget.height != widget.height) {
      if (mounted) setState(() {});
    }
    if (oldWidget.width != widget.width) {
      if (mounted) setState(() {});
    }
    if (oldWidget.src != widget.src) {
      if (mounted) setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return OptionalSizedChild(
      width: widget?.width,
      height: widget?.height,
      builder: (w, h) {
        final src = widget.src;
        _setup(src, w, h);
        return AbsorbPointer(
          child: HtmlElementView(
            key: widget?.key,
            viewType: widget.key.value,
          ),
        );
      },
    );
  }

  void _setup(String src, num width, num height) {
    final src = widget.src;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(widget.key.value, (int viewId) {
      final element = html.IFrameElement()
        ..style.border = '0'
        ..allowFullscreen = widget.webAllowFullScreen
        ..height = height.toInt().toString()
        ..width = width.toInt().toString();
      if (src != null) {
        // element..src = src;
        String _src = src.contains('<!DOCTYPE html>') ? src : _addWrapper(src);
        // print(_src);
        // element.setInnerHtml(_src);
        element.src = "data:text/html;charset=utf-8," + Uri.encodeComponent(_src);
      }
      return element;
    });
  }
}

String _addWrapper(String body) => """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
$body
</body>
</html>
  """;
