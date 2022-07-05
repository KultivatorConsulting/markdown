

import '../ast.dart';
import '../inline_parser.dart';
import 'inline_syntax.dart';

/// Matches jira link syntax: [test link|https://ralleeme.atlassian.net/browse/RUI-65]
class JiraLinkSyntax extends InlineSyntax {
  static final String _pattern =
      r'(\[)(.*)\|(.*)(\])';

  JiraLinkSyntax() : super(_pattern);

  @override
  bool onMatch(InlineParser parser, Match match) {
    final String textWithLinkUrl = match.input.substring(1,match.input.length-1);
    parser.addNode(Element.text('jira_link', textWithLinkUrl));
    return true;
  }
}
