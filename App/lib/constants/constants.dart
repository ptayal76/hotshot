import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  //fillColor: Colors.white10,
  filled: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.transparent)
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.transparent)
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.transparent)
  )
);