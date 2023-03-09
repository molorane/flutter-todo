import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../theme/colors.dart';

class TaskStatusCard extends StatelessWidget {
  const TaskStatusCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.amountOfFiles,
    required this.text,
  }) : super(key: key);

  final String title, svgSrc, amountOfFiles;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ctPadding),
      padding: EdgeInsets.all(ctPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: primaryColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(ctPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(
              svgSrc,
              color: Colors.red,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: ctPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "$text",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ctDarkGray),
                  ),
                ],
              ),
            ),
          ),
          Text(amountOfFiles)
        ],
      ),
    );
  }
}
