// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../ast.dart';
import '../block_parser.dart';
import '../patterns.dart';
import 'block_syntax.dart';

/// divider syntax '----' parse
class JiraDividerSyntax extends BlockSyntax {
  @override
  RegExp get pattern => jiraDividerPattern;

  const JiraDividerSyntax();

  @override
  Node parse(BlockParser parser) {
    parser.advance();
    return Element.empty('hr');
  }
}
