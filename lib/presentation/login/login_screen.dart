import 'package:flutter/material.dart';

import '../../app/constant/route.dart';
import '../ressource/color_manager.dart';
import '../ressource/image_manager.dart';
import '../ressource/size_manager.dart';
import '../ressource/string_manager.dart';
import '../ressource/style_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: Container(
          padding: const EdgeInsets.only(
            top: SizeManager.s120,
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
                              StringManager.login,
                              style: getBoldStyle18(color: ColorManager.white),
                            ),
                          ),
                          const SizedBox(
                            height: SizeManager.s15,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.registerRoute);
                            },
                            child: Text(
                              StringManager.registerLink,
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
