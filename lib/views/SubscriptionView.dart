import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthy/widgets/CustomButton.dart';
import '../constant.dart';
import '../widgets/CustomText.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  bool monthlyPlan = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Image.asset('assets/icons/back.png'),
          ),
        ),
        title: CustomText(
          txt: 'Subscriptions',
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontColor: primaryColor,
        ),
        leadingWidth: 55.w,
        centerTitle: true,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _planBox("Standard Plan", '\$7.99', 'monthly', monthlyPlan)),
                  SizedBox(width: 5.w,),
                  Expanded(child: _planBox("Standard Plan", '\$49.99', 'year', !monthlyPlan)),
                ],
              )
            ],
          )),
    );
  }

  Widget _planBox(title, price, type, selected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
      decoration: BoxDecoration(
          border: Border.all(color: selected == true ? primaryColor : colorThree),
          borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        children: [
          CustomText(
            txt: title,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                txt: price,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                txt: ' / ' + type,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontColor: colorSix,
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/icons/checkbox.png', height: 20.h, width: 20.w, color: selected ? primaryColor : colorThree),
              SizedBox(width: 8.w,),
              Expanded(
                child: CustomText(
                  txt: 'Unlock exclusive content',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/icons/checkbox.png', height: 20.h, width: 20.w, color: selected ? primaryColor : colorThree,),
              SizedBox(width: 8.w,),
              Expanded(
                child: CustomText(
                  txt: 'Get access to a world of new and updated recipes every month with our Monthly Subscription.',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h,),
          CustomButton(txt: 'Purchased', txtColor: selected ? whiteColor : colorThree, bColor: selected ? primaryColor : colorThree.withOpacity(0.5), bbColor: selected ? primaryColor : colorThree.withOpacity(0.5), width: 250.w, onTap: (){
            setState(() {
              monthlyPlan = !monthlyPlan;
            });
          })
        ],
      ),
    );
  }
}
