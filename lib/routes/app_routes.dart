import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:todo_app/pages/reminder/reminder_binding.dart';
import 'package:todo_app/pages/reminder/reminder_screen.dart';
import 'package:todo_app/pages/stream_builder/stream_builder_binding.dart';
import 'package:todo_app/pages/stream_builder/stream_builder_page.dart';
import 'package:todo_app/pages/add_task/add_task_binding.dart';
import 'package:todo_app/pages/add_task/add_task_screen.dart';
import 'package:todo_app/pages/create_new_password/create_new_password_binding.dart';
import 'package:todo_app/pages/create_new_password/create_new_password_screen.dart';
import 'package:todo_app/pages/edit_profile/edit_profile_binding.dart';
import 'package:todo_app/pages/edit_profile/edit_profile_screen.dart';
import 'package:todo_app/pages/forgot_password/forgot_password_binding.dart';
import 'package:todo_app/pages/forgot_password/forgot_password_screen.dart';
import 'package:todo_app/pages/home/home_binding.dart';
import 'package:todo_app/pages/home/home_screen.dart';
import 'package:todo_app/pages/mobile_signin/mobile_signin_binding.dart';
import 'package:todo_app/pages/mobile_signin/mobile_signin_screen.dart';
import 'package:todo_app/pages/otp/otp_binding.dart';
import 'package:todo_app/pages/otp/otp_screen.dart';
import 'package:todo_app/pages/profile_page/profile_binding.dart';
import 'package:todo_app/pages/profile_page/profile_screen.dart';
import 'package:todo_app/pages/register/register_binding.dart';
import 'package:todo_app/pages/register/register_screen.dart';
import 'package:todo_app/pages/signin/signin_binding.dart';
import 'package:todo_app/pages/signin/signin_screen.dart';
import 'package:todo_app/pages/verify_account/verify_ac_binding.dart';
import 'package:todo_app/pages/verify_account/verify_ac_screen.dart';
import 'package:todo_app/pages/welcome_page/welcome_binding.dart';
import 'package:todo_app/pages/welcome_page/welcome_screen.dart';
import 'package:todo_app/routes/app_page.dart';

class AppPages {
  static final List<GetPage> getPages = [
    GetPage(
      name: AppRoutes.registrationScreen,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.signinScreen,
      page: () => SigninScreen(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.addTaskScreen,
      page: () => AddTaskScreen(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: AppRoutes.verifyAccountScreen,
      page: () => VerifyAccountScreen(),
      binding: VerifyAccountBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.createNewPasswordScreen,
      page: () => CreateNewPasswordScreen(),
      binding: CreateNewPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 350),
    ),
    GetPage(
      name: AppRoutes.editProfileScreen,
      page: () => EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.welcomeScreen,
      page: () => WelcomeScreen(),
      binding: WelcomeBindings(),
    ),
    GetPage(
      name: AppRoutes.mobileSigninScreen,
      page: () => MobileSigninScreen(),
      binding: MobileSigninBinding(),
    ),
    GetPage(
      name: AppRoutes.otpScreen,
      page: () => OtpScreen(),
      binding: OtpBinding(),
    ),
    // initial route
    GetPage(
      name: AppRoutes.streamBuilderPage,
      page: () => StreamBuilderPage(),
      binding: StreamBuilderBinding(),
    ),
    GetPage(
      name: AppRoutes.reminderScreen,
      page: () => ReminderScreen(),
      binding: ReminderBinding(),
    ),
  ];
}
