import 'package:flutter/widgets.dart';
import 'package:todo/bloc/bloc.dart';

class BlocProvider<T extends Bloc> extends InheritedWidget {
  BlocProvider({
    this.bloc,
    this.child,
    this.key,
  }) : super(key: key);

  final Widget child;
  final T bloc;
  final Key key;

  @override
  bool updateShouldNotify(_) => true;

  static of<T extends Bloc>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>().bloc;
  }
}
