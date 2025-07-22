import 'package:get/get.dart';

import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/chatdetails/bindings/chatdetails_binding.dart';
import '../modules/chatdetails/views/chatdetails_view.dart';
import '../modules/course_details/bindings/course_details_binding.dart';
import '../modules/course_details/views/course_details_view.dart';
import '../modules/courses/bindings/courses_binding.dart';
import '../modules/courses/views/courses_view.dart';
import '../modules/examinstructions/bindings/examinstructions_binding.dart';
import '../modules/examinstructions/views/examinstructions_view.dart';
import '../modules/examlist/bindings/examlist_binding.dart';
import '../modules/examlist/views/examlist_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mcq/bindings/mcq_binding.dart';
import '../modules/mcq/views/mcq_view.dart';
import '../modules/myprofile/bindings/myprofile_binding.dart';
import '../modules/myprofile/views/myprofile_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/result/bindings/result_binding.dart';
import '../modules/result/views/result_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/testseries/bindings/testseries_binding.dart';
import '../modules/testseries/views/testseries_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.COURSES,
      page: () => const CoursesView(),
      binding: CoursesBinding(),
    ),
    GetPage(
      name: _Paths.COURSE_DETAILS,
      page: () => const CourseDetailsView(),
      binding: CourseDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.MYPROFILE,
      page: () => const MyprofileView(),
      binding: MyprofileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.TESTSERIES,
      page: () => const TestseriesView(),
      binding: TestseriesBinding(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: _Paths.EXAMLIST,
      page: () => const ExamlistView(),
      binding: ExamlistBinding(),
    ),
    GetPage(
      name: _Paths.EXAMINSTRUCTIONS,
      page: () => const ExaminstructionsView(),
      binding: ExaminstructionsBinding(),
    ),
    GetPage(
      name: _Paths.MCQ,
      page: () => const McqView(),
      binding: McqBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.CHATDETAILS,
      page: () => const ChatdetailsView(),
      binding: ChatdetailsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
