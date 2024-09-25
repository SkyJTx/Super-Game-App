import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/v4.dart';

class ValueChangeNotifier<T> extends Cubit<T> {
  late final String name;

  List<void Function(ValueChangeNotifier<T>)> listeners = [];

  ValueChangeNotifier(super.state, {String? name}) {
    this.name = name ?? const UuidV4().generate();
  }

  T get value => state;

  set value(T value) {
    emit(value);
  }

  void addListener(void Function(ValueChangeNotifier<T>) listener) {
    listeners.add(listener);
  }

  void removeListener(void Function(ValueChangeNotifier<T>) listener) {
    listeners.remove(listener);
  }

  void notifyListeners() {
    for (final listener in listeners) {
      listener(this);
    }
  }

  @override
  void emit(T state) {
    super.emit(state);
    notifyListeners();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueChangeNotifier<T> && runtimeType == other.runtimeType && state == other.state;

  @override
  int get hashCode => state.hashCode;
}
