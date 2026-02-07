import 'package:equatable/equatable.dart';

///
/// STATE
///
abstract class InternetConnectivityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InternetConnectivityStateInitial extends InternetConnectivityState {}

class InternetConnectivityStateConnected extends InternetConnectivityState {}

class InternetConnectivityStateDisconnected extends InternetConnectivityState {}
