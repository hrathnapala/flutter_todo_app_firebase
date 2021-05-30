import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnakBar(BuildContext context, String text) =>
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(text),
          backgroundColor: Colors.black,
        ));
  static DateTime? toDateTime(Timestamp value) {
    // ignore: unnecessary_null_comparison
    if (value == null) {
      return null;
    }
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    // ignore: unnecessary_null_comparison
    if (date == null) {
      return null;
    }

    return date.toUtc();
  }
}
