import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class AbstractEvent extends Equatable {
  AbstractEvent([List props = const []]) : super(props);
}