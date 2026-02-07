import 'package:equatable/equatable.dart';

///
/// EVENT
///
abstract class DrawersBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DrawersBlocEventLoadPainters extends DrawersBlocEvent {}
