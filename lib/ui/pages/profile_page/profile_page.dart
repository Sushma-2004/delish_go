import 'package:delish_go/logic/locator.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:delish_go/ui/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

void signOut(){
  Locator.userManagementService.signOut();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
                children: [
          GestureDetector(
            onTap: () => signOut(),
            child: Container(
              width: Dimensions.screenWidth/5,
              height: Dimensions.height45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: AppColors.mainColor,
              ),
              child: Center(
                  child: Text(
                "Logout",
                style: TextStyle(color: Colors.white,fontSize: Dimensions.font16),
              )),
            ),
          )
                ],
              ),
        ));
  }
}
