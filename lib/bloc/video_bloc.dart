import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../repository/repository.dart';
import './video_event.dart';
import './video_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int pageno = 1;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();

  HomeBloc() : super(const HomeInitial(null)) {
    scrollController.addListener(
      () {
        add(LoadMoreDataEvent());
      },
    );

    on<FetchDataEvent>((event, emit) async {
      emit(const DataLoadingState(null));
      var videos = await VideoRepository.getUserData(pageno: pageno);
      emit(DataLoadedState(videos: videos));
    });
    on<LoadMoreDataEvent>(
      (event, emit) async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          isLoading = true;
          pageno++;
          var newvideos = await VideoRepository.getUserData(pageno: pageno);

          emit(DataLoadedState(videos: [...state.videos, ...newvideos]));

          isLoading = false;
        }
      },
    );
  }
}
