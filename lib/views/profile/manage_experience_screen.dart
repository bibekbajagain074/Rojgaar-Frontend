import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class ManageExperienceScreen extends StatefulWidget {
  const ManageExperienceScreen({super.key});

  @override
  State<ManageExperienceScreen> createState() => _ManageExperienceScreenState();
}

class _ManageExperienceScreenState extends State<ManageExperienceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenUtils.customLabel(
              labelType: LabelType.heading1,
              text: 'Experiences',
              isBold: true,
              color: primaryColor),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ));
  }
}
