import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stdbook/constants/color_constants.dart';
import 'package:stdbook/core/utils/media_quiers.dart';
import 'package:stdbook/core/widgets/custom_container.dart';

class StadiumImages extends StatelessWidget {
  const StadiumImages({Key key, this.imageSrc, this.onTap, this.deleteImageAction, this.useLocalImage = false}) : super(key: key);
  final String imageSrc;
  final bool useLocalImage;
  final VoidCallback onTap;

  final VoidCallback deleteImageAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      onLongPress: () {
        deleteImageAction();
      },
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: CustomContainer(
          image: DecorationImage(
              image: useLocalImage
                  ? NetworkImage(
                      imageSrc,
                    )
                  : FileImage(
                      File(imageSrc),
                    ),
              fit: BoxFit.fill),
          height: height(context) * 0.2,
          width: whidth(context) * 0.4,
        ),
      ),
    );
  }
}

class Features extends StatelessWidget {
  const Features({Key key, this.featureType, this.onTap, this.onDeleteAction}) : super(key: key);
  final String featureType;
  final VoidCallback onTap;
  final VoidCallback onDeleteAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      onLongPress: () {
        onDeleteAction();
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 16, right: 16),
            child: Text(
              featureType,
              style: TextStyle(
                color: ColorConstants.darkGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
