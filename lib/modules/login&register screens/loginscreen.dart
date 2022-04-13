import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social/layouts/social_layout.dart';
import 'package:social/modules/login&register%20screens/register_screen.dart';

import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubits/login_screen/login_screen__states.dart';
import 'package:social/shared/cubits/login_screen/login_screen_cubit.dart';
import 'package:social/shared/network/local/cach_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.savetData(key: 'uID', value: state.uID)
                .then((value) {
              navigateAndRemove(
                  context: context, widget: const SocialLayoutScreen());
            })
                .catchError((e) {
              print(e.toString());
              print('____________-');
            });

          }

        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN ',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Log in now to communicate with your friends  ',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.blueGrey)),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: emailController,
                            textKeyboard: TextInputType.emailAddress,
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Email';
                              }
                            },
                            textLabel: 'EmailAddress'),
                        SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            onFieldSubmitted: (value) {},
                            controller: passwordController,
                            textKeyboard: TextInputType.text,
                            prefix: Icons.lock_outline,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                            },
                            textLabel: 'Password',
                            isPassword: LoginCubit
                                .get(context)
                                .isPassword,
                            suffixPressed: () {
                              LoginCubit.get(context).passwordVisibility();
                            },
                            suffix: LoginCubit
                                .get(context)
                                .suffix),
                        const SizedBox(
                          height: 20,
                        ),
                        Conditional.single(
                          conditionBuilder: (context) =>
                          state is LoginLoadingState,
                          widgetBuilder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                          fallbackBuilder: (context) =>
                              defaultButton(
                                  text: 'login',
                                  fun: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.loginFun(
                                          password: passwordController.text,
                                          email: emailController.text);
                                    }
                                  },
                                  isUpper: true),
                          context: context,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account ',
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                              width: 5,
                            ),
                            textButton(
                                text: "register now",
                                fun: () {
                                  navigateTo(
                                      context: context,
                                      widget: RegisterScreen());
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
