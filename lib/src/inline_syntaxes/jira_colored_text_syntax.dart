import '../ast.dart';
import '../inline_parser.dart';
import '../util.dart';
import 'inline_syntax.dart';

/// Matches Jira colored text syntax
class JiraColoredTextSyntax extends InlineSyntax {
  static final String _pattern =
      r'({color:#)([a-zA-Z0-9_.-]{6})(})(.*)({color})';

  JiraColoredTextSyntax() : super(_pattern);

  @override
  bool onMatch(InlineParser parser, Match match) {
    String colorHex = match[2]!;
    String text = match[4]!;
    parser.addNode(Element.text('color-$colorHex', text));
    return true;
  }
}
