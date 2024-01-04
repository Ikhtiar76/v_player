import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDataEvent extends HomeEvent {}

class LoadMoreDataEvent extends HomeEvent {}
