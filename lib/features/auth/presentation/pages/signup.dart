import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/core/routes/routes.dart';
import 'package:my_task_products/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_task_products/shared/classes/text_style.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/resources/color_resources.dart';
import 'package:my_task_products/shared/widgets/primary_button.dart';
import 'package:my_task_products/shared/widgets/snackbar.dart';
import 'package:my_task_products/shared/widgets/textformfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  //final String? role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            context.pushReplacementNamed(Routes.login,);
            showSnackBar("success created ${state.userEntity.username}");
          } else if (state is SignUpError) {
            showSnackBar("Ops ${state.message}");
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
            child: SingleChildScrollView(
              child: Form(
                key: context.read<AuthCubit>().signUpKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "welcome ",
                        style: AppTextStyle.textStyle(
                          appFontSize: 23.sp,
                          appFontWeight: FontWeight.w400,
                          color: ColorResources.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    CustomTextFormField(
                      hintText: "user name",
                      obscureText: true,
                      controller: context.read<AuthCubit>().usernameRegister,
                    ),
                    SizedBox(height: 14.h),
                    CustomTextFormField(
                      hintText: "first name",
                      obscureText: true,
                      controller: context.read<AuthCubit>().firstName,
                    ),
                    SizedBox(height: 14.h),
                    CustomTextFormField(
                      hintText: "second Name",
                      obscureText: true,
                      controller: context.read<AuthCubit>().secondName,
                    ),
                    SizedBox(height: 14.h),
                    CustomTextFormField(
                      hintText: "age",
                      obscureText: true,
                      controller: context.read<AuthCubit>().age,
                    ),
                    SizedBox(height: 14.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return CustomTextFormField(
                          controller:
                              context.read<AuthCubit>().passwordRegister,
                          obscureText:
                              context.read<AuthCubit>().isShowPasswordRegister,
                          suffixIconOnTap: () {
                            context.read<AuthCubit>().displayPasswordRegister();
                          },
                          hintText: "password",
                          suffixIcon:
                              context.read<AuthCubit>().isShowPasswordRegister
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                        );
                      },
                    ),

                    SizedBox(height: 20.h),
                    PrimaryButton(
                      onPressed: () async {
                        await context.read<AuthCubit>().register();
                      },
                      title: "login",
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () async {
                        context.pushReplacementNamed(Routes.login);
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account",
                              style: AppTextStyle.textStyle(
                                appFontSize: 14.sp,
                                appFontWeight: FontWeight.w400,
                                color: Color(0xff002237),
                              ),
                            ),
                            TextSpan(
                              text: " Login",
                              style: AppTextStyle.textStyle(
                                appFontSize: 15.sp,
                                appFontWeight: FontWeight.w400,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
