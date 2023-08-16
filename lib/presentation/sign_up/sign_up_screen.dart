import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoes_store/presentation/ressource/color_manager.dart';
import 'package:shoes_store/presentation/ressource/image_manager.dart';
import 'package:shoes_store/presentation/ressource/size_manager.dart';
import 'package:shoes_store/presentation/ressource/string_manager.dart';
import 'package:shoes_store/presentation/ressource/style_manager.dart';

import '../../app/constant/route.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: const EdgeInsets.only(
          top: SizeManager.s100,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 45,
                      height: 45,
                      child: Image(
                        image: AssetImage(ImageManager.logo),
                      ),
                    ),
                    const SizedBox(
                      width: SizeManager.s10,
                    ),
                    Text(
                      StringManager.appName,
                      style: getBoldStyle(color: ColorManager.black, ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s15),
                  //color: ColorManager.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(SizeManager.s18),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: StringManager.name,
                            filled: true,
                            fillColor: ColorManager.ultraLightGrey,
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(SizeManager.s18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: StringManager.email,
                            filled: true,
                            fillColor: ColorManager.ultraLightGrey,
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(SizeManager.s18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: StringManager.password,
                            filled: true,
                            fillColor: ColorManager.ultraLightGrey,
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(SizeManager.s18),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: SizeManager.s20,
                        ),
                        Container(
                          width: double.infinity,
                          height: SizeManager.s60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: ColorManager.black,
                              borderRadius: BorderRadius.circular(SizeManager.s18)
                          ),
                          child: Text(
                            StringManager.register,
                            style: getBoldStyle18(color: ColorManager.white),
                          ),
                        ),
                        const SizedBox(
                          height: SizeManager.s15,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.loginRoute);
                          },
                          child: Text(
                            StringManager.login,
                            style: getMediumStyleF(
                              color: ColorManager.lightBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
