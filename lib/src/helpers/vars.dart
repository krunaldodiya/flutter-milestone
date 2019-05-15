import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/material.dart';

String appName = "MileStone";

String baseUrl = kReleaseMode
    ? "https://api.milestoneducation.com"
    : "http://192.168.2.200:8000";

var primaryColor = Colors.redAccent;

var youtubeApi = "AIzaSyAyiq3H_2hwy98_FWqKyZDpbrjzgyOy9GM";
