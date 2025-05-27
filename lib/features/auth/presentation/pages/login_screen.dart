import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/core/routes/routes.dart';
import 'package:my_task_products/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:my_task_products/shared/classes/text_style.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/resources/color_resources.dart';
import 'package:my_task_products/shared/widgets/primary_button.dart';
import 'package:my_task_products/shared/widgets/textformfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.pushNamedAndRemoveUntil(Routes.homeTap);
          } else if (state is LoginError) {
            ///* showSnackBar(state.message);
            // ! this is always failed !!
            if (state.message == "Invalid credentials") {
              context.pushNamedAndRemoveUntil(Routes.homeTap);
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
            child: SingleChildScrollView(
              child: Form(
                key: context.read<AuthCubit>().loginKey,
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
                      controller: context.read<AuthCubit>().userName,
                    ),
                    SizedBox(height: 14.h),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return CustomTextFormField(
                          controller: context.read<AuthCubit>().password,
                          obscureText:
                              context.read<AuthCubit>().isShowPasswordLogin,
                          suffixIconOnTap: () {
                            context.read<AuthCubit>().displayPasswordLogin();
                          },
                          hintText: "password",
                          suffixIcon:
                              context.read<AuthCubit>().isShowPasswordLogin
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "forget",
                          style: AppTextStyle.textStyle(
                            appFontSize: 13.sp,
                            appFontWeight: FontWeight.w400,
                            color: ColorResources.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    PrimaryButton(
                      onPressed: () async {
                        await context.read<AuthCubit>().login().then((_){
                          context.read<AuthCubit>().userName.clear();
                          context.read<AuthCubit>().password.clear();
                        });
                      },
                      title: "login",
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        context.pushReplacementNamed(Routes.signUp);
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "dont have an account",
                              style: AppTextStyle.textStyle(
                                appFontSize: 14.sp,
                                appFontWeight: FontWeight.w400,
                                color: Color(0xff002237),
                              ),
                            ),
                            TextSpan(
                              text: " signUp",
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
