import 'package:flutter/material.dart';

abstract class CustomState<S extends StatefulWidget, T extends Bloc> extends State with Screen<T>, WidgetsBindingObserver {
  onStart();
  onStop();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onStart();
    });
  }

  @override
  void dispose() {
    super.dispose();
    onStop();
  }
}

abstract class Bloc {}

mixin Screen<T> {
  Bloc bloc = T as Bloc;
}
