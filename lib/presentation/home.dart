import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:v_player/presentation/video_page.dart';

import '../bloc/video_bloc.dart';
import '../bloc/video_event.dart';
import '../bloc/video_state.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(FetchDataEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Trending Videos',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is DataLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is DataLoadedState) {
            var videos = state.videos;
            return ListView.builder(
              controller: context.read<HomeBloc>().scrollController,
              itemCount: context.read<HomeBloc>().isLoading
                  ? videos.length + 1
                  : videos.length,
              itemBuilder: (context, index) {
                if (index >= videos.length) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else {
                  var video = videos[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPage(
                            videoUrl: video.manifest,
                            title: video.title,
                            views: video.viewers,
                            image: video.channelImage,
                            channel_name: video.channelName,
                            channel_subscriber: video.channelSubscriber,
                          ),
                        ),
                      );
                    },
                    child: YouTubeCard(
                        thumbnailUrl: video.thumbnail ?? '',
                        channelLogoUrl: video.channelImage ?? '',
                        views: video.viewers,
                        date: video.dateAndTime.toString(),
                        title: video.title),
                  );
                }
              },
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

class YouTubeCard extends StatelessWidget {
  final String thumbnailUrl;
  final String channelLogoUrl;
  final String title;
  final String views;
  final String date;

  YouTubeCard(
      {required this.thumbnailUrl,
      required this.channelLogoUrl,
      required this.title,
      required this.views,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200.0,
            errorBuilder: (context, error, stackTrace) {
              print('Error loading thumbnail image: $error');
              return const Icon(
                  Icons.error); // Replace with your preferred error indication
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(channelLogoUrl),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 48.0),
                Text(views),
                const SizedBox(width: 2.0),
                const Text('views'),
                const SizedBox(width: 8.0),
                Text(date)
              ],
            ),
          )
        ],
      ),
    );
  }
}
