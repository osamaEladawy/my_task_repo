import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/app_injections.dart';
import 'package:my_task_products/core/functions/show_dialog.dart';
import 'package:my_task_products/features/home_tap/presentation/cubit/home_tap_cubit.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/resources/color_resources.dart';
import 'package:my_task_products/shared/widgets/primary_button.dart';

class HomeTapScreen extends StatelessWidget {
  const HomeTapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeTapCubit>(),
      child: BlocBuilder<HomeTapCubit, HomeTapState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedIconTheme: IconThemeData(
                color: ColorResources.primaryColor,
              ),
              currentIndex: context.read<HomeTapCubit>().currentIndex,
              onTap: (value) {
                context.read<HomeTapCubit>().changePage(value);
              },
              elevation: 10,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "User",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2),
                  label: "Admin",
                ),
              ],
            ),
            body: PopScope(
              canPop: false,
              child: context.read<HomeTapCubit>().pages.elementAt(
                context.read<HomeTapCubit>().currentIndex,
              ),
              onPopInvokedWithResult: (d, s) {
                showDialog(
                  context: context,
                  builder: (_) {
                    return alert("Haye!", "Are You Exit App", [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20.w,
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: PrimaryButton(
                              title: "No",
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 80.w,
                            child: PrimaryButton(
                              title: "Yes",
                              onPressed: () {
                                exit(0);
                              },
                            ),
                          ),
                        ],
                      ),
                    ]);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
