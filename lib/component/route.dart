import 'dart:collection';

import 'package:flutter/widgets.dart';

final class Route {
  final String identifier;
  final Key? key;
  final String name;
  final Widget Function(BuildContext, Widget) wrapper;
  final Widget Function(BuildContext, Key?) builder;
  Route? parent;
  final List<Route> children;

  Route({
    required this.identifier,
    this.key,
    required this.name,
    required this.wrapper,
    required this.builder,
    this.parent,
    this.children = const <Route>[],
  }) {
    for (final child in children) {
      child.parent = this;
    }
  }

  String get path {
    if (parent == null) {
      return name;
    }
    return '${parent!.path}/$name';
  }

  List<Route> toList() {
    final HashSet<Route> visited = HashSet<Route>();
    final List<Route> stack = <Route>[];
    stack.add(this);
    while (stack.isNotEmpty) {
      final Route current = stack.removeLast();
      if (visited.contains(current)) {
        continue;
      }
      visited.add(current);
      for (final child in current.children) {
        stack.add(child);
      }
    }
    return visited.toList();
  }

  Map<String, Route> toMap() {
    final List<Route> routes = toList();
    final Map<String, Route> map = <String, Route>{};
    for (final route in routes) {
      map[route.identifier] = route;
    }
    return map;
  }

  Route? find(String identifier) {
    final Map<String, Route> map = toMap();
    return map[identifier];
  }

  @override
  String toString() {
    return 'Route{identifier: $identifier, key: $key, name: $name, path: $path}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is Route) {
      return identifier == other.identifier;
    }
    return false;
  }

  @override
  int get hashCode {
    return identifier.hashCode;
  }
}
