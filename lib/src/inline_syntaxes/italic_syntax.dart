// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'delimiter_syntax.dart';

class ItalicSyntax extends DelimiterSyntax {
  //_italic_
 ItalicSyntax()
      : super(
          r'\_+',
          requiresDelimiterRun: true,
          allowIntraWord: true,
          tags: _tags,
        );

  static final _tags = [DelimiterTag('em', 1)];
}
