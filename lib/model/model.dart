// To parse this JSON data, do
//
//     final video = videoFromJson(jsonString);

import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  Links? links;
  int? total;
  int? page;
  int? pageSize;
  List<Result>? results;

  Video({
    this.links,
    this.total,
    this.page,
    this.pageSize,
    this.results,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        total: json["total"],
        page: json["page"],
        pageSize: json["page_size"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "links": links?.toJson(),
        "total": total,
        "page": page,
        "page_size": pageSize,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Links {
  int? next;
  dynamic previous;

  Links({
    this.next,
    this.previous,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
        previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "previous": previous,
      };
}

class Result {
  String? thumbnail;
  int? id;
  String? title;
  DateTime? dateAndTime;
  String? slug;
  DateTime? createdAt;
  String? manifest;
  int? liveStatus;
  String? liveManifest;
  bool? isLive;
  String? channelImage;
  ChannelName? channelName;
  ChannelUsername? channelUsername;
  bool? isVerified;
  ChannelSlug? channelSlug;
  String? channelSubscriber;
  int? channelId;
  Type? type;
  String? viewers;
  String? duration;
  ObjectType? objectType;

  Result({
    this.thumbnail,
    this.id,
    this.title,
    this.dateAndTime,
    this.slug,
    this.createdAt,
    this.manifest,
    this.liveStatus,
    this.liveManifest,
    this.isLive,
    this.channelImage,
    this.channelName,
    this.channelUsername,
    this.isVerified,
    this.channelSlug,
    this.channelSubscriber,
    this.channelId,
    this.type,
    this.viewers,
    this.duration,
    this.objectType,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        thumbnail: json["thumbnail"] ?? "",
        id: json["id"] ?? 0,
        title: json["title"] ?? "",
        dateAndTime: json["date_and_time"] != null
            ? DateTime.parse(json["date_and_time"])
            : null,
        slug: json["slug"] ?? "",
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        manifest: json["manifest"] ?? "",
        liveStatus: json["live_status"] ?? 0,
        liveManifest: json["live_manifest"] ?? "",
        isLive: json["is_live"] ?? false,
        channelImage: json["channel_image"] ?? "",
        channelName: channelNameValues.map[json["channel_name"]] ??
            ChannelName.ONE_UMMAH,
        channelUsername: channelUsernameValues.map[json["channel_username"]] ??
            ChannelUsername.SAKIBLIVETV,
        isVerified: json["is_verified"] ?? false,
        channelSlug: channelSlugValues.map[json["channel_slug"]] ??
            ChannelSlug.ONE_UMMAH,
        channelSubscriber: json["channel_subscriber"] ?? "",
        channelId: json["channel_id"] ?? 0,
        type: typeValues.map[json["type"]] ?? Type.OTHERS,
        viewers: json["viewers"] ?? "",
        duration: json["duration"] ?? "",
        objectType:
            objectTypeValues.map[json["object_type"]] ?? ObjectType.VIDEO,
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "id": id,
        "title": title,
        "date_and_time": dateAndTime?.toIso8601String(),
        "slug": slug,
        "created_at": createdAt?.toIso8601String(),
        "manifest": manifest,
        "live_status": liveStatus,
        "live_manifest": liveManifest,
        "is_live": isLive,
        "channel_image": channelImage,
        "channel_name": channelNameValues.reverse[channelName],
        "channel_username": channelUsernameValues.reverse[channelUsername],
        "is_verified": isVerified,
        "channel_slug": channelSlugValues.reverse[channelSlug],
        "channel_subscriber": channelSubscriber,
        "channel_id": channelId,
        "type": typeValues.reverse[type],
        "viewers": viewers,
        "duration": duration,
        "object_type": objectTypeValues.reverse[objectType],
      };
}

enum ChannelName { ONE_UMMAH, SAKIB_LIVE_TV, SAYED_TV_TS }

final channelNameValues = EnumValues({
  "One Ummah": ChannelName.ONE_UMMAH,
  "Sakib Live TV": ChannelName.SAKIB_LIVE_TV,
  "Sayed TV TS": ChannelName.SAYED_TV_TS
});

enum ChannelSlug { ONE_UMMAH, SAKIB_LIVE_TV, SAYED_TV_TS }

final channelSlugValues = EnumValues({
  "one-ummah": ChannelSlug.ONE_UMMAH,
  "sakib-live-tv": ChannelSlug.SAKIB_LIVE_TV,
  "sayed-tv-ts": ChannelSlug.SAYED_TV_TS
});

enum ChannelUsername { SAKIBLIVETV, SDFSDF1 }

final channelUsernameValues = EnumValues({
  "sakiblivetv": ChannelUsername.SAKIBLIVETV,
  "sdfsdf1": ChannelUsername.SDFSDF1
});

enum ObjectType { VIDEO }

final objectTypeValues = EnumValues({"video": ObjectType.VIDEO});

enum Type { OTHERS, TILAWAT, WAZ }

final typeValues = EnumValues(
    {"Others": Type.OTHERS, "Tilawat": Type.TILAWAT, "Waz": Type.WAZ});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
