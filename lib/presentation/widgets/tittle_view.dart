import 'package:fake_json/presentation/widgets/styles.dart';
import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  final String? title;

  const TitleView({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title ?? '',
            style: Styles().extraBigSizeBoldText(Colors.black),
          ),
        ),
      ],
    );
  }
}
