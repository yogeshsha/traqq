import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/colors_constants.dart';
import 'helper.dart';

class ImageBuilder {
  static Widget imageBuilder(String url,
      {double? curve, double? paddingAll, Widget? showReplaceWidget}) {
    bool checkUrl = AppHelper.isValidUrl(url);

    String sendUrl = url;

    return ClipRRect(
      borderRadius: BorderRadius.circular(curve ?? 15),
      child: url.isNotEmpty && checkUrl
          // true
          ? CachedNetworkImage(
              imageUrl: sendUrl,
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  // const ShimmerComponent(),
                  Transform.scale(
                scale: 0.3,
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: ColorsConstants.appColor,
                ),
              ),
              errorWidget: (context, url, error) =>
                  showReplaceWidget ??
                  Padding(
                    padding: EdgeInsets.all(paddingAll ?? 16),
                    child: Icon(Icons.person,
                        color: ColorsConstants.appColor, size: 16),
                  ),
            )
          : showReplaceWidget ??
              Padding(
                padding: EdgeInsets.all(paddingAll ?? 16),
                child: Icon(Icons.person,
                    color: ColorsConstants.appColor, size: 16),
              ),
    );
  }
}
