import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_finde_hotel/core/api/api_methods.dart';
import 'package:hotel_finde_hotel/core/resource/size_manager.dart';
import 'package:hotel_finde_hotel/core/storage/shared/shared_pref.dart';
import 'package:hotel_finde_hotel/core/widget/button/main_app_button.dart';
import 'package:hotel_finde_hotel/core/widget/form_field/title_app_form_filed.dart';

import 'package:http/http.dart' as http;
import '../../../core/api/api_links.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../../router/router.dart';
import '../../../core/helper/validation_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> fkey = GlobalKey();

  void onSignInClicked() {
    Navigator.of(context).pushNamed(RouteNamedScreens.login);
  }

  void onSignUpClicked() async {
    if (!fkey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: AppHeightManager.h2,
            width: AppHeightManager.h2,
            child: CircularProgressIndicator(
              color: AppColorManager.red,
            ),
          ),
        ],
      )),
    );
    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.register, {
      "name": name.text,
      "email": email.text,
      "password": password.text,
    });
    var body = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      AppSharedPreferences.cashUserName(username: body['user data']['name']);
      AppSharedPreferences.cashUserid(id: body['user data']['id'].toString());
      AppSharedPreferences.cashUserToken(token: body['token']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextWidget(
            text: "Welcome To Hotel Finder",
            color: AppColorManager.white,
            fontSize: FontSizeManager.fs14,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.visible,
          ),
        ),
      );
      Navigator.of(context).pushNamed(RouteNamedScreens.bottomAppBar);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppTextWidget(
          text: body,
          color: AppColorManager.white,
          fontSize: FontSizeManager.fs14,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: fkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.75,
                width: AppWidthManager.w100,
                decoration: const BoxDecoration(),
                child: SvgPicture.asset("assets/icons/curve.svg"),
              ),
              Padding(
                padding: EdgeInsets.all(AppWidthManager.w3Point8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppHeightManager.h1,
                    ),
                    AppTextWidget(
                      text: "Create An Account.",
                      color: AppColorManager.black,
                      fontSize: FontSizeManager.fs20,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: AppHeightManager.h05,
                    ),
                    AppTextWidget(
                      text: "Register With Your Valid Email Address.",
                      color: AppColorManager.black,
                      fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    Container(
                      width: AppWidthManager.w10,
                      color: Colors.black,
                      height: AppHeightManager.h05,
                    ),
                    SizedBox(
                      height: AppHeightManager.h5,
                    ),
                    TitleAppFormFiled(
                      hint: "Name",
                      title: "Name",
                      onChanged: (value) {
                        name.text = value ?? "";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Empty Field";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "Email Address",
                      title: "Email Address",
                      onChanged: (value) {
                        email.text = value ?? "";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Empty Field";
                        }
                        if (!(value?.isEmail() ?? false)) {
                          return "Invalid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "Password",
                      title: "Password",
                      onChanged: (value) {
                        password.text = value ?? "";
                        return null;
                      },
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Empty Field";
                        }
                        if ((value?.length ?? 0) < 6) {
                          return "Invalid Password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainAppButton(
                          onTap: onSignUpClicked,
                          alignment: Alignment.center,
                          width: AppWidthManager.w30,
                          height: AppHeightManager.h5,
                          color: AppColorManager.black,
                          child: AppTextWidget(
                            text: "Sign Up",
                            color: AppColorManager.white,
                            fontSize: FontSizeManager.fs14,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        SizedBox(
                          width: AppWidthManager.w5,
                        ),
                        MainAppButton(
                          onTap: onSignInClicked,
                          outLinedBorde: true,
                          borderColor: AppColorManager.black,
                          alignment: Alignment.center,
                          width: AppWidthManager.w30,
                          height: AppHeightManager.h5,
                          color: AppColorManager.white,
                          child: AppTextWidget(
                            text: "Sign In",
                            color: AppColorManager.black,
                            fontSize: FontSizeManager.fs14,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.visible,
                          ),
                        )
                      ],
                    )
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