import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stdbook/constants/color_constants.dart';
import 'package:stdbook/core/utils/media_quiers.dart';

class BottomSheetUtil {
  showDeleteAndChangeBottomSheet(BuildContext context, {VoidCallback changeButtonCallBack, VoidCallback deleteButtonCallBack}) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(
              width: whidth(context),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: height(context) * 0.06,
                      width: whidth(context) * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(
                          onPressed: () {
                            changeButtonCallBack();
                            Navigator.pop(context);
                          },
                          child: Text('Change'),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ColorConstants.darkGreen)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height(context) * 0.03,
                    ),
                    Container(
                      height: height(context) * 0.06,
                      width: whidth(context) * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red[900])),
                          onPressed: () {
                            deleteButtonCallBack();
                            Navigator.pop(context);
                          },
                          child: Text('Delete'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
