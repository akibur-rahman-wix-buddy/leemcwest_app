import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:leemcwest/assets_helper/app_fonts.dart';

class HtmlViewWidget extends StatelessWidget {
  final String input;
  const HtmlViewWidget({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(''' $input ''', customStylesBuilder: (element) {
      if (element.classes.contains('foo')) {
        return {'color': 'red'};
      }
      return null;
    }, customWidgetBuilder: (element) {
      if (element.attributes['foo'] == 'bar') {
        // render a custom widget that takes the full width
      }
      if (element.attributes['fizz'] == 'buzz') {
        // render a custom widget that inlines with surrounding text
      }
      return null;
    },
        renderMode: RenderMode.column,
        textStyle: TextFontStyle.headlinePublicSans40012);
  }
}
