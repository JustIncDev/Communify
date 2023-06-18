import 'dart:convert';
import 'dart:io';

import 'package:alice/alice.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

import '../log_service.dart';

part 'alice_log_service.dart';
part 'console_log_service.dart';
part 'file_log_service.dart';
part 'firebase_log_service.dart';