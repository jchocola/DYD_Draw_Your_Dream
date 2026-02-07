import 'dart:async';
import 'package:dyd_drawer/feature/feature_internet_connectivity/bloc/internet_connectivity_event.dart';
import 'package:dyd_drawer/feature/feature_internet_connectivity/bloc/internet_connectivity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
export 'package:dyd_drawer/feature/feature_internet_connectivity/bloc/internet_connectivity_event.dart';
export 'package:dyd_drawer/feature/feature_internet_connectivity/bloc/internet_connectivity_state.dart';

///
/// BLOC
///
class InternetConnectivityBloc
    extends Bloc<InternetConnectivityEvent, InternetConnectivityState> {
  StreamSubscription<InternetStatus>? _subscription;

  InternetConnectivityBloc() : super(InternetConnectivityStateInitial()) {
    on<InternetStatusChangedEvent>((event, emit) {
      if (event.status == InternetStatus.connected) {
        emit(InternetConnectivityStateConnected());
      } else {
        emit(InternetConnectivityStateDisconnected());
      }
    });

    _subscription = InternetConnection().onStatusChange.listen((status) {
      add(InternetStatusChangedEvent(status));
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
