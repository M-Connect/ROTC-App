import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rotc_app/Views/addGCEvent.dart';
import 'package:rotc_app/app/peerReview/activityToBeEvaluated.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/executionGraphViewPage.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/leadershipGraphViewPage.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/planningGraphViewPage.dart';
import 'package:rotc_app/app/peerReview/graphs/graphActivitySelector.dart';

import 'package:rotc_app/app/peerReview/evaluationForms/debrief.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/communicationGraphViewPage.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/debriefGraphViewPage.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/execution.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/individualEvalConfirmationPage.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/multipleEvalConfirmationPage.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/multipleUserActivityToBeEvaluated.dart';
import 'package:rotc_app/app/peerReview/evaluationForms/usersToDoEvaluation.dart';
//import 'package:rotc_app/app/peerReview/peerReviewStats.dart';
import 'package:rotc_app/app/profile/editProfile.dart';
import 'package:rotc_app/common_widgets/barGraphWidget2.0.dart';
import 'package:rotc_app/services/auth.dart';
import 'Views/passwords/ForgotPassword.dart';
import 'Views/registrationPage.dart';
import 'Views/signInPage.dart';
import 'Views/welcomePage.dart';
import 'app/Schedule/CalendarTasks.dart';
import 'app/Schedule/evaluationCalendarTasks.dart';
import 'app/home.dart';
import 'app/peerReview/graphs/barGraphs.dart';
import 'app/peerReview/graphs/lineGraphs.dart';
import 'app/peerReview/evaluationForms/communication.dart';
import 'app/peerReview/evaluationForms/confirmation.dart';
import 'app/peerReview/evaluationForms/leadership.dart';
import 'app/peerReview/evaluationForms/peerReviewLLAB2FT.dart';
import 'app/peerReview/evaluationForms/planning.dart';
import 'app/peerReview/evaluationForms/execution.dart';
import 'app/peerReview/evaluationForms/debrief.dart';
import 'app/peerReview/notifications.dart';
import 'app/peerReview/multipleUsersToEvaluate.dart';
import 'app/peerReview/singleUserToEvaluate.dart';
import 'app/peerReview/peerReviewLanding.dart';
import 'app/profile/profile.dart';
/*
  Author: Kyle Serruys
  created main and MConnect class.
  Co-Author: Christine Thomas
  created routes and added more Theme colors.
  Co-Author: Mac-Rufus Umeokolo
 */

final GlobalKey<NavigatorState> navigation = new GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MConnect());
  });
}

class MConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(
          create: (_) => Auth(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Auth>().authState,
          initialData: null,
        )
      ],
      child: MaterialApp(
          title: 'Firebase Authentication',
          navigatorKey: navigation,
          home: Authenticate(),
          initialRoute: '/signIn',
          routes: {
            '/signIn': (context) => SignInView(),
            '/welcomePage': (context) => WelcomeView(),
            '/register': (context) => RegistrationView(),
            '/homePage': (context) => HomeView(),
            '/forgotPassword': (context) => ForgotPasswordView(),
            '/profile': (context) => Profile(),
            '/editProfile': (context) => EditProfile(),
            '/calendar': (context) => CalendarTasks(),
            '/evaluationCalendarTasks': (context) => EvaluationCalendarTasks(),
            '/activityToBeEvaluated': (context) => ActivityToBeEvaluated(),
            '/peerReviewLanding': (context) => PeerReviewForm(),
            '/graphActivitySelector': (context) => GraphActivitySelector(),
            '/peerReview': (context) => SingleUserToEvaluate(),
           // '/peerReviewStats': (context) => PeerReviewStats(),
            '/peerReviewRequest': (context) => MultipleUsersToEvaluate(),
            '/peerReviewLLAB2FT': (context) => PeerReviewLLAB2FT(),
            '/planning': (context) => Planning(),
            '/communication': (context) => Communication(),
            '/execution': (context) => Execution(),
            '/leadership': (context) => Leadership(),
            '/debrief': (context) => Debrief(),
            '/confirmation': (context) => Confirmation(),
            '/individualEvalConfirmationPage': (context) =>
                IndividualEvalConfirmationPage(),
            '/multipleEvalConfirmationPage': (context) =>
                MultipleEvalConfirmationPage(),
            '/usersToDoEvaluation': (context) => UsersToDoEvaluation(),
            '/multipleUserActivityToBeEvaluated': (context) =>
                MultipleUserActivityToBeEvaluated(),
            '/notifications': (context) => Notifications(),
            '/barGraph': (context) => BarGraphv2(),
            '/addGCEvent': (context) => AddGCEvent(),
            '/communicationGraphViewPage': (context) =>
                CommunicationGraphViewPage(),
            '/debriefGraphViewPage': (context) => DebriefGraphViewPage(),
            '/leadershipGraphViewPage': (context) => LeadershipGraphViewPage(),
            '/executionGraphViewPage': (context) => ExecutionGraphViewPage(),
            '/planningGraphViewPage': (context) => PlanningGraphViewPage(),
            '/lineGraph': (context) => LineGraph(),
          }),
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomeView();
    }
    return SignInView();
  }
}
