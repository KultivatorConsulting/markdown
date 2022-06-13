import 'delimiter_syntax.dart';

/// Matches jira subscript syntax:  ~sub~
class JiraSubscriptSyntax extends DelimiterSyntax {
  JiraSubscriptSyntax()
      : super(
           r'~+',
          requiresDelimiterRun: true,
          allowIntraWord: true,
          tags: [DelimiterTag('subscript', 1)],
        );
}
