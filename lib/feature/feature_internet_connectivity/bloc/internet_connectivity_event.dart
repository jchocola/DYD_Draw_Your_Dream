import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

///
/// EVENT
///
abstract class InternetConnectivityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InternetStatusChangedEvent extends InternetConnectivityEvent {
  final InternetStatus status;
  InternetStatusChangedEvent(this.status);

  @override
  List<Object?> get props => [status];
}