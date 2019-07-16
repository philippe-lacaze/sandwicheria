import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AbstractState extends Equatable {
  AbstractState([List props = const []]) : super(props);
}