import 'package:dyd_drawer/feature/feature_drawers/domain/entity/painter_entity.dart';
import 'package:equatable/equatable.dart';

///
/// STATE
///
abstract class DrawersBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DrawersBlocStateInitial extends DrawersBlocState {}

class DrawersBlocStateLoading extends DrawersBlocState {}

class DrawersBlocStateLoaded extends DrawersBlocState {
  final List<PainterEntity> painters;
  DrawersBlocStateLoaded({required this.painters});
  @override
  List<Object?> get props => [painters];
}