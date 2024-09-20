import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class ManageCategoryScreen extends StatefulWidget {
  const ManageCategoryScreen({super.key});

  @override
  State<ManageCategoryScreen> createState() => _ManageCategoryScreenState();
}

class _ManageCategoryScreenState extends State<ManageCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenUtils.customLabel(
              labelType: LabelType.heading1,
              text: 'Categories',
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
