import 'package:flutter/material.dart';

class new_button1 extends StatelessWidget {
  final String text;
  final IconData ic;
  final Function()? onTap;
  const new_button1({
    Key? key,
    required this.text,
    required this.ic,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            padding: EdgeInsets.all(1.5),
            color: Color.fromARGB(255, 239, 102, 105),
            child: ClipOval(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(0.1),
                child: IconButton(
                  onPressed: onTap,
                  icon: Icon(ic, size: 32,color: Color.fromARGB(255, 239, 102, 105)),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            text,
            style: TextStyle(
                color: Color.fromARGB(255, 239, 102, 105), fontWeight: FontWeight.w700, fontSize: 17),
          ),
        ),
      ],
    );
  }
}
