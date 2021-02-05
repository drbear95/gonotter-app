import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class ApplicationPage extends StatelessWidget {
  final navigator = GetIt.I<FluroRouter>();
}
