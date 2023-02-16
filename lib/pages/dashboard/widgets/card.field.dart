import 'package:flutter/material.dart';

class CardField extends StatelessWidget {
  final Size size;
  final Color color;
  final Icon icon;
  final String title;
  final String subtitle;

  const CardField({super.key,
    required this.size,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
          child: SizedBox(
              height: size.height * .1,
              width: size.width * .30,
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color,
                    child: icon,
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  subtitle: Text(
                    subtitle,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ))),
    );
  }
}
