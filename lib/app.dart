

import 'package:flutter/material.dart';
import 'package:logger/logger.dart' as log;
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';



var logger = log.Logger();

extension StreamChatContext on BuildContext {

  User? get currentUser => StreamChatCore.of(this).currentUser;
  String? get currentUserImage => currentUser!.image;
}

