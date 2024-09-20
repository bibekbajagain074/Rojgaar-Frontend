import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class ManageAcademicScreen extends StatefulWidget {
  const ManageAcademicScreen({super.key});

  @override
  State<ManageAcademicScreen> createState() => _ManageAcademicScreenState();
}

class _ManageAcademicScreenState extends State<ManageAcademicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenUtils.customLabel(
              labelType: LabelType.heading1,
              text: 'Academics',
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
