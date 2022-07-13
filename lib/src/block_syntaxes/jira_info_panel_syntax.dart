import '../ast.dart';
import '../block_parser.dart';
import '../charcode.dart';
import '../patterns.dart';
import '../util.dart';
import 'block_syntax.dart';

/// Parses preformatted code blocks between two {panel} sequences.

class JiraInfoPanelSyntax extends BlockSyntax {
  @override
  RegExp get pattern => jiraInfoPanelPattern;

  const JiraInfoPanelSyntax();

  @override
  List<String> parseChildLines(BlockParser parser, [String? endBlock]) {
    endBlock ??= '';

    final childLines = <String>[];
    parser.advance();
    while (!parser.isDone) {
      final match = pattern.firstMatch(parser.current);
      if (match == null || !match[1]!.startsWith(endBlock)) {
        childLines.add(parser.current);
        parser.advance();
      } else {
        parser.advance();
        break;
      }
    }

    return childLines;
  }

  @override
  Node parse(BlockParser parser) {
    // Get the syntax identifier, if there is one.
    final match = pattern.firstMatch(parser.current)!;
    final colorHexString = match.group(2)!;
    final colorHex = colorHexString.substring(colorHexString.indexOf('#')+1);
    final endBlock = '{panel';

    final childLines = parseChildLines(parser, endBlock);

    var text = childLines.join('\n');
    if (parser.document.encodeHtml) {
      text = escapeHtml(text);
    }
    final code = Text(text);

    final element = Element('panel', [code]);
    if (colorHex.isNotEmpty) {
      element.attributes['color'] = colorHex;
    }

    return element;
  }
}
