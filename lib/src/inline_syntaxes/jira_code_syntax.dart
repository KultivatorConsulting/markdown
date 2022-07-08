import 'package:intl/intl.dart' show DateFormat;

import '../ast.dart';
import '../inline_parser.dart';
import '../util.dart';
import 'inline_syntax.dart';

/// Matches inline code syntax{{code}}, this syntax also include date format support
class JiraCodeSyntax extends InlineSyntax {
  static final String _pattern = r'{{(.+)}}';

  JiraCodeSyntax() : super(_pattern);

  @override
  bool onMatch(InlineParser parser, Match match) {
    var code = match[1]!;
    if (isDate(code)) {
      //check if date, show it in the same format as Jira
      final String dateText = DateFormat('d MMM,y').format(DateTime.parse(code));
      parser.addNode(Element.text('code', dateText));
      return true;
    }
    if (parser.encodeHtml) code = escapeHtml(code);
    parser.addNode(Element.text('code', code));
    return true;
  }

  bool isDate(String str) {
    try {
      DateTime.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
