import 'package:delish_go/loading_page.dart';
import 'package:delish_go/logic/app_management_service/navigation_service.dart';
import 'package:delish_go/logic/data_management_service/user_management_service.dart';
import 'package:delish_go/ui/pages/Authentication/signupPage.dart';
import 'package:delish_go/ui/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

class ScreenSelector extends StatelessWidget with WatchItMixin {
  ScreenSelector({super.key});

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(250, 31, 33, 39),
          title: const Text(
            'Error',
            style: TextStyle(color: Colors.white70),
          ),
          content: const Text(
            "Please Check Email or Password",
            style: TextStyle(color: Colors.white70),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData =
        watchValue((UserManagementService x) => x.userData);
    bool isLoading =
        watchValue((NavigationService x) => x.isLoadingNotifier);

    registerHandler(
        select: (UserManagementService x) => x.invalidUser,
        handler: (context, value, cancel) =>
            showErrorDialog(context, value.toString()));

    if (isLoading == true) {
      return const LoadingScreen();
    } else {
      if (userData != null) {
        return const HomePage();
      } else {
        return SignupPage();
      }
    }
  }
}
