import 'package:flutter/material.dart';
import 'package:sga/client/component/value_change_notifier.dart';

class MultipleValueChangeNotifierSelector<T> extends StatefulWidget {
  final List<ValueChangeNotifier> valueChangeNotifiers;
  final T Function() selector;
  final Widget Function(BuildContext context, T state) builder;

  const MultipleValueChangeNotifierSelector({
    super.key,
    required this.valueChangeNotifiers,
    required this.selector,
    required this.builder,
  });

  @override
  State<MultipleValueChangeNotifierSelector<T>> createState() => MultipleValueChangeNotifierSelectorState<T>();
}

class MultipleValueChangeNotifierSelectorState<T> extends State<MultipleValueChangeNotifierSelector<T>> {
  late T state;

  @override
  void initState() {
    state = widget.selector();
    for (final notifier in widget.valueChangeNotifiers) {
      notifier.addListener(_onValueChanged);
    }
    super.initState();
  }

  @override
  void dispose() {
    for (final notifier in widget.valueChangeNotifiers) {
      notifier.removeListener(_onValueChanged);
    }
    super.dispose();
  }

  void _onValueChanged(ValueChangeNotifier notifier) {
    setState(() {
      state = widget.selector();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state);
  }
}
