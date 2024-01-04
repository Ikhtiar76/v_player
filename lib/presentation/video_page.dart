import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../model/model.dart';

class VideoPage extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String views;
  final String image;
  final ChannelName channel_name;
  final String channel_subscriber;

  const VideoPage({
    Key? key,
    required this.videoUrl,
    required this.title,
    required this.views,
    required this.image,
    required this.channel_name,
    required this.channel_subscriber,
  }) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFututre;
  bool isVideoPlaying = true;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFututre =
        _videoPlayerController.initialize().then((value) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  FutureBuilder(
                    future: _initializeVideoPlayerFututre,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isVideoPlaying) {
                                  _videoPlayerController.pause();
                                } else {
                                  _videoPlayerController.play();
                                }
                                isVideoPlaying = !isVideoPlaying;
                              });
                            },
                            child: VideoPlayer(_videoPlayerController),
                          ),
                        );
                      } else {
                        return Container(
                          color: Colors.black,
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        );
                      }
                    },
                  ),
                  if (!isVideoPlaying)
                    IconButton(
                      icon:
                          Icon(Icons.play_arrow, size: 50, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _videoPlayerController.play();
                          isVideoPlaying = true;
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.05,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Color(0xFF1A202C),
                    fontSize: 15,
                    fontFamily: 'Hind Siliguri',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    '${widget.views} views',
                    style: const TextStyle(
                      color: Color(0xFF718096),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomWidget(
                    iconTitle: 'MASH ALLAH',
                    count: 12,
                    icon: Icons.favorite_border,
                  ),
                  CustomWidget(
                    iconTitle: 'Like',
                    count: 12,
                    icon: Icons.thumb_up_alt_outlined,
                  ),
                  CustomWidget(
                    iconTitle: 'Share',
                    icon: Icons.share_outlined,
                  ),
                  CustomWidget(
                    iconTitle: 'Report',
                    icon: Icons.flag_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.05,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(widget.image)),
                          const SizedBox(width: 5),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.channel_name.name.toString(),
                                style: const TextStyle(
                                  color: Color(0xFF1A202C),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  height: 0.10,
                                ),
                              ),
                              Text(
                                "${widget.channel_subscriber} Subcribers",
                                style: const TextStyle(
                                  color: Color(0xFF718096),
                                  fontSize: 11,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0.13,
                                  letterSpacing: -0.22,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 109,
                      height: 33,
                      padding: const EdgeInsets.only(
                          top: 8, left: 12, right: 14, bottom: 8),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF3898FC),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      child: const Center(
                        child: Text(
                          '+ Subscribe',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 25,
                width: MediaQuery.of(context).size.width / 1.05,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: const Text(
                        'Comments 7.5K',
                        style: TextStyle(
                          color: Color(0xFF718096),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 47,
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: 'Add Comment',
                              hintStyle: TextStyle(
                                color: Color(0xFFCBD5E0),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0.09,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.send,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 10,
                width: MediaQuery.of(context).size.width / 1.05,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const Icon(
                        Icons.person_pin,
                        size: 40,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Fahmida khanom    2 days ago"),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'হুজুরের বক্তব্য গুলো ইংরেজি তে অনুবাদ করে সারা \nপৃথিবীর মানুষদের কে শুনিয়ে দিতে হবে। কথা গুলো খুব দামি'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final String iconTitle;
  final int? count;
  final IconData icon;

  CustomWidget({
    required this.iconTitle,
    this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 125,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Icon(
                          icon,
                          size: 24,
                          // Customize the icon's appearance as needed
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        iconTitle,
                        style: const TextStyle(
                          color: Color(0xFF718096),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0.14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '($count)',
                        style: const TextStyle(
                          color: Color(0xFF718096),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0.14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
