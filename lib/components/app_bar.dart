import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const CustomAppBar({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF242426),
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 64,
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.28,
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.only(left: 8),
        padding: const EdgeInsets.only(left: 18),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Image.asset("images/back_arrow.png"),
        ),
      ),
    );
  }
}
