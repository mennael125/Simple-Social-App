import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social/layouts/social_layout.dart';

import 'package:social/shared/components/components.dart';
import 'package:social/shared/cubits/register_screen/register_screen__states.dart';
import 'package:social/shared/cubits/register_screen/register_screen_cubit.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
if (state is USerCreateSuccessState) {
  navigateAndRemove(context: context, widget: SocialLayoutScreen());
}
          },
          builder: (context, state) {
            var cubit=RegisterCubit.get(context);
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
                            'Register ',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Register  now to communicate with your friends ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.blueGrey)),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: nameController,
                              textKeyboard: TextInputType.name,
                              prefix: Icons.person,
                              validate: (value) {
                                if (value!.isEmpty)
                                  return 'Please enter your Name';
                                if (value.length < 2)
                                  return 'Your name is too short';
                              },
                              textLabel: 'User Name'),
                          SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                              controller: emailController,
                              textKeyboard: TextInputType.emailAddress,
                              prefix: Icons.email_outlined,
                              validate: (value) {
                                if (value!.isEmpty)
                                  return 'Please enter your Email';
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
                                if (value!.isEmpty)
                                  return 'Enter password';
                                if (value.length<6)
                                  return 'Password is too short';
                              },
                              textLabel: 'Password',
                              isPassword: RegisterCubit.get(context).isPassword,
                              suffixPressed: () {
                                RegisterCubit.get(context).passwordVisibility();
                              },
                              suffix: RegisterCubit.get(context).suffix),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              helper: 'ex: 01xxxxxxxxx',
                              textKeyboard: TextInputType.phone,
                              prefix: Icons.phone,
                              validate: (value) {
                                if (value!.isEmpty )
                                  return 'Number must be enter';
                                if (value.length ==10 ){
                                  isPhoneNoValid(value);
                                  return 'Number must start with 01';}
                                if (value.length < 11||value.length > 11 )
                                  return 'Number must be 10 digit';


                              },
                              textLabel: 'Phone'),
                          SizedBox(
                            height: 10,
                          ),
                          Conditional.single(
                            context: context,
                            conditionBuilder: (context) =>
                           state is USerCreateLoadingState || state is RegisterLoadingState ,
                            fallbackBuilder: (context) => defaultButton(
                                text: 'Register',
                                fun: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.registerFun(userName: nameController.text, password: passwordController.text, email: emailController.text, phone: phoneController.text

                                    );

                                }}
                                ,isUpper: true),
                    widgetBuilder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
    // );
  }
}
