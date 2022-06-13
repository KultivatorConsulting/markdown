import 'delimiter_syntax.dart';

/// Matches jira superscript syntax:  ^super^
class JiraSuperscriptSyntax extends DelimiterSyntax {
  JiraSuperscriptSyntax()
      : super(
           r'\^+',
          requiresDelimiterRun: true,
          allowIntraWord: true,
          tags: [DelimiterTag('superscript', 1)],
        );
}
