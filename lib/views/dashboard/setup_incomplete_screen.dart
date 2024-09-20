import 'package:flutter/material.dart';
import 'package:roj_gaar_app/utils/constants.dart';

import '../utils/screen_utils.dart';

class SetupPromptScreen extends StatefulWidget {
  const SetupPromptScreen({super.key});

  @override
  State<SetupPromptScreen> createState() => _SetupPromptScreenState();
}

class _SetupPromptScreenState extends State<SetupPromptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: ScreenUtils.customLabel(
                  maxLines: 2,
                  labelType: LabelType.heading1,
                  text: 'Profile incomplete, please setup your profile first.'),
            ),
          ],
        )
      ],
    ));
  }
}
