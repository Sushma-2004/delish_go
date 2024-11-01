import 'package:delish_go/logic/locator.dart';
import 'package:delish_go/ui/reusable_widgets/app_text_field.dart';
import 'package:delish_go/ui/reusable_widgets/big_text.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:delish_go/ui/utils/dimensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninPage extends StatelessWidget {
   SigninPage({super.key});

    var emailController = TextEditingController();
    var passController = TextEditingController();

   void signIn(BuildContext context){
     final email = emailController.text.trim();
     final password = passController.text.trim();

      if (email.isNotEmpty && password.isNotEmpty) {
      Locator.userManagementService.signInWithEmailAndPassword(email, password);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: Dimensions.screenHeight * 0.05,
          ),
          Container(
            height: Dimensions.screenHeight * 0.25,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                backgroundImage: AssetImage("assets/image/logo.png"),
              ),
            ),
          ),
          AppTextField(
              textController: emailController,
              hintText: "Email",
              icon: Icons.email),
          SizedBox(
            height: Dimensions.height20,
          ),
          AppTextField(
              textController: passController,
              hintText: "Password",
              icon: Icons.password_sharp),
          SizedBox(
            height: Dimensions.height30,
          ),
          GestureDetector(
            onTap: ()=> signIn(context),
            child: Container(
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenHeight / 13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.mainColor,
              ),
              child: Center(
                child: BigText(
                  text: "Sign in",
                  size: Dimensions.font20 + Dimensions.font20 / 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          RichText(
              text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                  text: "Forget Password?",
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: Dimensions.font20)))
        ],
      ),
    );
  }
 
}


