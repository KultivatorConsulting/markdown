// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../ast.dart';
import '../block_parser.dart';
import '../patterns.dart';
import 'block_syntax.dart';

/// Parses atx-style jira image: `!image-`.
class JiraImageSyntax extends BlockSyntax {
  @override
  RegExp get pattern => jiraImagePattern;

  const JiraImageSyntax();

  @override
  Node parse(BlockParser parser) {
    final match = pattern.firstMatch(parser.current)!;
    parser.advance();
    final String src = match[2]!;
    final element = Element.empty('jira_img');
    // element.attributes['src'] = src;
    element.attributes['src'] = '/assets/images/ralleeme-logo-full.png';
    return element;
  }
}
