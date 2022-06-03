

import 'delimiter_syntax.dart';

/// Matches jira underline syntan:  +underline content+
class JiraUnderlineSyntax extends DelimiterSyntax {
  JiraUnderlineSyntax()
      : super(
           r'\++',
          requiresDelimiterRun: true,
          allowIntraWord: true,
          tags: [DelimiterTag('underline', 1)],
        );
}
