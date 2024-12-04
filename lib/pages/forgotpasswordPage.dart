import 'package:flutter/material.dart';
import 'package:login_app/components/custom_button.dart';
import 'package:login_app/components/custom_textfield.dart';
import 'package:login_app/pages/loginPage.dart';
import 'package:login_app/services/authentication_service.dart';
import 'package:login_app/services/handle_firebase_exception.dart';
import 'package:login_app/utils/load_spinner.dart';
import 'package:login_app/utils/snackbar_service.dart';
import 'package:login_app/utils/validator.dart';

class Forgotpasswordpage extends StatefulWidget {
  static const String id = "forgot_password_page";

  const Forgotpasswordpage({super.key});

  @override
  State<Forgotpasswordpage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<Forgotpasswordpage> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";

  void forgotPassword() async {
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      final status = await AuthenticationService.resetPassword(username: _email);
      if(status == AuthStatus.successful){
        DisplaySpinner.hide();
        if(!mounted) return;
        SnackbarService.displaySnackbar(context,"Check your email to reset password", SnackbarStatus.success);
        Navigator.pushNamedAndRemoveUntil(context, Loginpage.id, (route)=> false);
      }else {
        DisplaySpinner.hide();
        final err = HandleFirebaseException.generateErrMsg(status);
        if(!mounted) return;
        SnackbarService.displaySnackbar(context, err, SnackbarStatus.error);
      }
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              const Text("Forgot Your Password",style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 20,),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text("Enter your username and we will send instructions to reset your password",style: TextStyle(fontSize: 20),
              )),
              const SizedBox(height: 40,),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(children: [
                    CustomTextfield(
                      label: "Username",
                      obscureText: false,
                      hintText: "Your email",
                      onSaves: (newValue){
                        _email = newValue!;
                      },
                      validator: (value) => Validator.validateEmail(value ?? ""),
                    ),
                    const SizedBox(height: 40,),
                    CustomButton(onTap: forgotPassword, txt: "Continue"),
                  ]
                  ),
                ))
            ],
          ),
        ),
      ),
    );
  }
}
