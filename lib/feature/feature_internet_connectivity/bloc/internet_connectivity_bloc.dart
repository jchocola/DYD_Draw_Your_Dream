// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

///
/// EVENT
///
abstract class InternetConnectivityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class _InternetStatusChangedEvent extends InternetConnectivityEvent {
  final InternetStatus status;
  _InternetStatusChangedEvent(this.status);

  @override
  List<Object?> get props => [status];
}

///
/// STATE
///
abstract class InternetConnectivityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InternetConnectivityState_initial extends InternetConnectivityState {}
class InternetConnectivityState_connected extends InternetConnectivityState {}
class InternetConnectivityState_disconnected extends InternetConnectivityState {}

///
/// BLOC
///
class InternetConnectivityBloc
    extends Bloc<InternetConnectivityEvent, InternetConnectivityState> {
  
  StreamSubscription<InternetStatus>? _subscription;

  InternetConnectivityBloc() : super(InternetConnectivityState_initial()) {
    

    on<_InternetStatusChangedEvent>((event, emit) {
      if (event.status == InternetStatus.connected) {
        emit(InternetConnectivityState_connected());
      } else {
        emit(InternetConnectivityState_disconnected());
      }
    });

    _subscription = InternetConnection().onStatusChange.listen((status) {
      add(_InternetStatusChangedEvent(status));
    });
  }


  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}