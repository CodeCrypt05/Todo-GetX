import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/const/const.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/widget/common/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 180.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Const().welcomBanner,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 240.h),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 152.w,
                          child: CustomButton(
                            label: 'Register',
                            press: () {
                              Get.toNamed(AppRoutes.registrationScreen);
                            },
                            color: Colors.transparent,
                            textColor: kColorBlackNeutral800,
                            borderColor: kColorBlackNeutral800,
                          ),
                        ),
                        Container(
                          width: 152.w,
                          child: CustomButton(
                            label: 'Login',
                            press: () {
                              Get.toNamed(AppRoutes.signinScreen);
                            },
                            color: kColorPrimary,
                            textColor: kColorWhite,
                            borderColor: kColorPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    CustomButton(
                      label: 'Signin with mobile number',
                      press: () {
                        Get.toNamed(AppRoutes.mobileSigninScreen);
                      },
                      color: Colors.transparent,
                      textColor: kColorBlackNeutral800,
                      borderColor: kColorGreyNeutral400,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
