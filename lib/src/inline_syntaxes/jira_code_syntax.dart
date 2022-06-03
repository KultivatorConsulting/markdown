import '../ast.dart';
import '../inline_parser.dart';
import '../util.dart';
import 'inline_syntax.dart';

/// Matches inline code syntax{{code}}
class JiraCodeSyntax extends InlineSyntax {
  static final String _pattern = r'{{(.+)}}';


  JiraCodeSyntax() : super(_pattern);

  @override
  bool onMatch(InlineParser parser, Match match) {
    var code = match[1]!;
    if (parser.encodeHtml) code = escapeHtml(code);
    parser.addNode(Element.text('code', code));
    return true;
  }
}
