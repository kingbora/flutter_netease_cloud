import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class IndexPageEvent extends Equatable {
  IndexPageEvent([List props = const []]) : super(props);
}

class InitialPage extends IndexPageEvent {
  @override
  String toString() => "initial_page";
}