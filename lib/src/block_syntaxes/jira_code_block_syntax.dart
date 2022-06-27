import '../ast.dart';
import '../block_parser.dart';
import '../charcode.dart';
import '../patterns.dart';
import '../util.dart';
import 'block_syntax.dart';

/// Parses preformatted code blocks between two {noformat} sequences.

class JiraCodeBlockSyntax extends BlockSyntax {
  @override
  RegExp get pattern => jiraCodeBlockPattern;

  const JiraCodeBlockSyntax();

  @override
  List<String> parseChildLines(BlockParser parser, [String? endBlock]) {
    endBlock ??= '';

    final childLines = <String>[];
    bool isAdvanced = false;
    while (!parser.isDone) {
      final match = pattern.firstMatch(parser.current);
      if (match == null || !isAdvanced || !match[2]!.startsWith(endBlock)) {
        childLines.add(parser.current);
        parser.advance();
        isAdvanced = true;
      } else {
        childLines.add(parser.current);
        parser.advance();
        isAdvanced = true;
        break;
      }
    }

    return childLines;
  }

  @override
  Node parse(BlockParser parser) {
    // Get the syntax identifier, if there is one.
    final match = pattern.firstMatch(parser.current)!;
    final endBlock = match.group(1);
    var infoString = match.group(2)!;

    final childLines = parseChildLines(parser, endBlock);

    // The Markdown tests expect a trailing newline.
    childLines.add('');

    var text = childLines.join('\n').replaceAll('{noformat}', '');
    if (parser.document.encodeHtml) {
      text = escapeHtml(text);
    }
    final code = Text(text);

    // the info-string should be trimmed
    // http://spec.commonmark.org/0.22/#example-100
    infoString = infoString.trim();
    if (infoString.isNotEmpty) {
      // only use the first word in the syntax
      // http://spec.commonmark.org/0.22/#example-100
      final firstSpace = infoString.indexOf(' ');
      if (firstSpace >= 0) {
        infoString = infoString.substring(0, firstSpace);
      }
      if (parser.document.encodeHtml) {
        infoString = escapeHtmlAttribute(infoString);
      }
      //code.attributes['class'] = 'language-$infoString';
    }

    final element = Element('pre', [code]);

    return element;
  }
}
