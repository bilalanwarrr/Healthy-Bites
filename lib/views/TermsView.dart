import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy/constant.dart';
import '../widgets/CustomText.dart';

class TermsView extends StatelessWidget {
  const TermsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Image.asset('assets/icons/back.png'),
          )
        ),
        title: CustomText(
          txt: 'Terms of Use',
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontColor: primaryColor,
        ),
        centerTitle: true,
        leadingWidth: 55.w,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna Lorem ipsum '
                'dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna\n\nLorem ipsum dolor sit amet, '
                'consectetur adipiscing elit. Maecenas pulvinar bibendum magna Lorem ipsum dolor sit amet, consectetur adipiscing '
                'elit. Maecenas pulvinar bibendum magnaLorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar '
                'bibendum magna Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas pulvinar bibendum magna',
              style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),)
          ],
        ),
      ),
    );
  }
}
