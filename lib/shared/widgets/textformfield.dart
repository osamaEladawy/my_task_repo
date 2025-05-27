import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../classes/text_style.dart';
import '../resources/color_resources.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final void Function()? onTap;
  final void Function()? suffixIconOnTap;
  //final ValueChanged<String> valueChanged;
  final IconData? icon;
  final IconData? suffixIcon;
  final bool? obscureText;
  final String image;
  final void Function()? onPressed;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final bool isName;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.onTap,
    this.icon,
    this.obscureText,
    //required this.valueChanged,
    this.suffixIconOnTap,
    this.suffixIcon,
    this.image = "",
    this.onPressed,
    this.prefixIcon,
    this.keyboardType,
    this.isName = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText == null || obscureText == false ? true : false,
        validator: (value) {
          if (value!.isEmpty) {
            return "please entre this text field";
          } else {
            return null;
          }
        },
        controller: controller,
        // onFieldSubmitted: (value) {
        //   return valueChanged(value);
        // },
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 16.w, left: 16.w,top: 12.h,bottom: 12.h),
          hintStyle: AppTextStyle.textStyle(
            appFontSize: 16.sp,
            appFontWeight: FontWeight.w400,
            color:  Color(0xffC1C9D3),
          ),
          suffixIcon: IconButton(
            onPressed: suffixIconOnTap,
            icon: Icon(
              suffixIcon,
              color:Colors.black,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color:Color(0xffC1C9D3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Color(0xffC1C9D3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Color(0xffC1C9D3)),
          ),
          fillColor: ColorResources.whiteColor,
          filled: true,
          hintText: hintText,
          labelText: labelText,
          prefixIcon:image.isNotEmpty || image != ""? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: SvgPicture.asset(image, height: 18.h, width: 18.w),
          ):null,
        ),
      ),
    );
  }
}
