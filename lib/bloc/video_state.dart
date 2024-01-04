import 'package:equatable/equatable.dart';

import '../model/model.dart';

abstract class HomeState extends Equatable {
  final videos;

  const HomeState(this.videos);
}

class HomeInitial extends HomeState {
  const HomeInitial(super.videos);

  @override
  List<Object?> get props => [videos];
}

class DataLoadingState extends HomeState {
  const DataLoadingState(super.videos);

  @override
  List<Object?> get props => [videos];
}

class DataLoadedState extends HomeState {
  const DataLoadedState({required videos}) : super(videos);

  @override
  List<Object?> get props => [videos];
}

class NoMoreDataState extends HomeState {
  const NoMoreDataState() : super(null); // You can pass any value you want here

  @override
  List<Object?> get props => [];
}
