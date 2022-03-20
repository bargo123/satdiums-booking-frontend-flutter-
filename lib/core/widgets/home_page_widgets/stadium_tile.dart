import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stdbook/core/utils/media_quiers.dart';
import 'package:stdbook/core/widgets/custom_container.dart';

class StadiumTile extends StatelessWidget {
  const StadiumTile({Key key, this.stadiumName, this.price, this.image, this.onTap}) : super(key: key);
  final String stadiumName;
  final String price;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 8, top: 8),
        child: CustomContainer(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                child: Container(
                  height: 200,
                  width: whidth(context),
                  child: Image.network(
                    image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Text(
                              stadiumName,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            CustomContainer(
                              height: 25,
                              borderRadius: BorderRadius.circular(8),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '4.5',
                                    style: TextStyle(fontSize: 10, color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                              backgroundColor: Color(0xff0c3d27),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 15,
                              color: Colors.grey,
                            ),
                            Text(
                              'Wehdat, Amman ',
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              price,
                              style: TextStyle(fontSize: 17, color: Color(0xff0c3d27), fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '/Hour',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          spreadRadius: 2,
          shadowOpacity: 0.1,
          hasShadow: true,
          blurRadius: 5,
        ),
      ),
    );
  }
}
