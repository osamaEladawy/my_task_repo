import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_task_products/app_injections.dart' as di;
import 'package:my_task_products/core/apis/links/api_keys.dart';
import 'package:my_task_products/core/routes/routes.dart';
import 'package:my_task_products/core/storage/pref_services.dart';
import 'package:my_task_products/features/roles/presentation/cubit/roles_cubit.dart';
import 'package:my_task_products/features/roles/presentation/widgets/select_role.dart';
import 'package:my_task_products/shared/extentions/navigations.dart';
import 'package:my_task_products/shared/resources/color_resources.dart';
import 'package:my_task_products/shared/widgets/snackbar.dart';

class RolesScreen extends StatelessWidget {
  RolesScreen({super.key});
  final List<String> words = [ApiKeys.user, ApiKeys.admin];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RolesCubit>(
      create: (context) => di.sl<RolesCubit>(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Text(
                  "welcome",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 23.sp),
                ),
                SizedBox(height: 20.h),
                BlocBuilder<RolesCubit, RolesState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12.h,
                      children: [
                        ...List.generate(words.length, (index) {
                          return SelectYourRole(
                            title: words[index],
                            onTap: () {
                              context.read<RolesCubit>().selectRole(index);
                              PrefServices.instance.saveData(
                                key: ApiKeys.role,
                                value: words[index],
                              );
                              showSnackBar("Role is ${words[index]}");
                              context.pushNamed(
                                Routes.login,
                                arguments: words[index],
                              );
                            },
                            border:
                                context.read<RolesCubit>().indexRole == index
                                    ? Color(0xffC1C9D3)
                                    : Color(0xff19446A),

                            background:
                                context.read<RolesCubit>().indexRole == index
                                    ? ColorResources.whiteColor
                                    : Color(0xffE8ECF0),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
