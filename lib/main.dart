import 'package:families_app/primary_page.dart';
import 'package:families_app/utils/inits.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  final cubits = await initCubits();
  runApp(PrimaryPage(cubits: cubits));
}
