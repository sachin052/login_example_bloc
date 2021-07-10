import 'dart:async';

import 'package:rxdart/rxdart.dart';

class CustomStreamController<T> {
  final StreamTransformer<T, T> _transformer;

  final _controllerController = BehaviorSubject<T>();

  CustomStreamController(this._transformer);

  Function(T) get changeData => _controllerController.sink.add;

  Stream<T> get data => _controllerController.stream.transform(_transformer);

  void addError(String error) => _controllerController.sink.addError;

  T? get dateValue  => _controllerController.hasValue?_controllerController.value:null;

  void dispose() {
    _controllerController.close();
  }
}
