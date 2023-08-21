import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoes_store/app/function.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoadingVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return isLoadingVisible
        ? loading(StringManager.loading)
        : Scaffold(
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
                    const Column(
                      children: [
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: Image(
                            image: AssetImage(ImageManager.logo),
                          ),
                        ),
                        SizedBox(
                          height: SizeManager.s10,
                        ),
                      ],
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
                          controller: _nameController,
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
                          /*onChanged: (value) {
                            setInputValue(value, name);
                          },*/
                        ),
                        const SizedBox(
                          height: SizeManager.s20,
                        ),
                        TextField(
                          controller: _emailController,
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
                          controller: _passwordController,
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
                        GestureDetector(
                          onTap: () {
                            register();
                          },
                          child: Container(
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
                        ),
                        const SizedBox(
                          height: SizeManager.s15,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.loginRoute);
                          },
                          child: Text(
                            StringManager.loginLink,
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

  //----------------------------------------------------------------------------
  // Register user
  //----------------------------------------------------------------------------

  register() async {
    setState(() {
      isLoadingVisible = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _emailController.text.trim(),
    );

    if (userCredential.user != null) {
      User user = userCredential.user!;

      // Save user data in db --------------------------------------------------
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection("users").doc(user.uid).set({
        "name": _nameController.text,
        "email": _emailController.text,
      });
      setState(() {
        isLoadingVisible = false;
      });
    }
  }
}
