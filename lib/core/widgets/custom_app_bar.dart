import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: () {
          // Auth().logOut();
        },
        child: Center(child: Text('Logout')),
      ),
      toolbarHeight: 75,
      centerTitle: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/santara.png',
            height: 100,
            width: 200,
            color: Colors.white,
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
      backgroundColor: Color(0xff54c56d),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(80, 80);
}
