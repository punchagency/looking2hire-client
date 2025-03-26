import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/constants/app_color.dart';

import 'custom_text.dart';

class CustomLabelInputText extends StatelessWidget {
  const CustomLabelInputText({
    super.key,
    required this.label,
    this.controller,
    this.placeholder,
    this.counterText,
    this.maxLength,
    this.maxLines,
    this.minLines,
    required this.keyboardType,
    required this.inputAction,
    this.validate,
    this.enabled,
    this.obscureText = false,
    this.readOnly = false,
    this.required = false,
    this.labelColor,
    this.borderColor,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixIcon,
    this.prefixIcon,
    this.onKeyUp,
    this.fontStyle,
    this.fontWeight,
    this.onTap,
  });

  final String label;
  final TextEditingController? controller;
  final String? placeholder;
  final String? counterText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final FormFieldValidator<String>? validate;
  final bool? enabled;
  final bool obscureText;
  final bool readOnly;
  final bool required;
  final Color? labelColor;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final Function(String)? onKeyUp;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != ""
            ? Row(
              children: [
                CustomOpenSansText(
                  text: label,
                  textColor: labelColor ?? Colors.black,
                  textSize: 16.sp,
                  fontStyle: fontStyle,
                  fontWeight: fontWeight,
                ),
                if (required)
                  CustomOpenSansText(
                    text: "*",
                    textColor: AppColor.primaryColor,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
              ],
            )
            : Container(),
        if (label != "") SizedBox(height: 10.h),
        TextFormField(
          onChanged: onKeyUp,
          controller: controller,
          validator: validate,
          onTap: onTap,
          textInputAction: inputAction,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLines,
          minLines: minLines,

          decoration: InputDecoration(
            fillColor: AppColor.grey[100]?.withOpacity(.2),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 13.0,
              horizontal: 10.0,
            ),
            border: OutlineInputBorder(
              // borderSide: BorderSide.none,
              borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              // borderSide: BorderSide.none,
              borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              // borderSide: BorderSide.none,
              borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
              borderRadius: BorderRadius.circular(10),
            ),
            // border: InputBorder.none,
            filled: true,
            hintText: placeholder,
            prefixIcon: prefixIcon,
            counterText: counterText,
            hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey[600],
            ),
            // border: InputBorder.none,
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 30,
              maxWidth: 35,
              minHeight: 20,
            ),
          ),
          readOnly: readOnly,
          enabled: enabled,
          cursorColor: AppColor.primaryColor,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
        ),
      ],
    );
  }
}

class CustomInputText extends StatelessWidget {
  const CustomInputText({
    super.key,
    this.label,
    this.controller,
    this.placeholder,
    this.counterText,
    this.maxLength,
    this.maxLines,
    this.letterSpacing,
    required this.keyboardType,
    required this.inputAction,
    this.validate,
    this.enabled,
    this.obscureText = false,
    this.readOnly = false,
    this.required = false,
    this.labelColor,
    this.borderColor,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixIcon,
    this.prefixIcon,
    this.onKeyUp,
    this.onTap,
    this.focusNode,
  });

  final String? label;
  final TextEditingController? controller;
  final String? placeholder;
  final String? counterText;
  final int? maxLength;
  final int? maxLines;
  final double? letterSpacing;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final FormFieldValidator<String>? validate;
  final bool? enabled;
  final bool obscureText;
  final bool readOnly;
  final bool required;
  final Color? labelColor;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final Function(String)? onKeyUp;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 51,
      child: TextFormField(
        onTap: onTap,
        onChanged: onKeyUp,
        controller: controller,
        validator: validate,
        textInputAction: inputAction,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLines: maxLines,
        focusNode: focusNode,
        style: TextStyle(letterSpacing: letterSpacing, color: AppColor.black),
        decoration: InputDecoration(
          fillColor: Colors.white,
          counter: const SizedBox.shrink(),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? AppColor.borderLight,
              width: .1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: placeholder,
          prefixIcon: prefixIcon,
          counterText: counterText,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey[600],
          ),

          // border: InputBorder.none,
          suffixIcon: suffixIcon,
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 30,
            maxWidth: 35,
            minHeight: 20,
          ),
        ),
        readOnly: readOnly,
        enabled: enabled,
        cursorColor: AppColor.primaryColor,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        obscureText: obscureText,
      ),
    );
  }
}

class CustomLabelUnderlineInputText extends StatelessWidget {
  const CustomLabelUnderlineInputText({
    super.key,
    required this.label,
    required this.controller,
    this.placeholder,
    this.prefixText,
    this.suffixText,
    this.maxLength,
    required this.keyboardType,
    required this.inputAction,
    this.validate,
    this.enabled,
    this.obscureText = false,
    this.readOnly = false,
    this.labelColor,
    this.borderColor,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixIcon,
    this.prefixIcon,
    this.onKeyUp,
    this.onEditingComplete,
    this.isPassword = false,
  });

  final String label;
  final TextEditingController controller;
  final String? placeholder;
  final String? prefixText;
  final String? suffixText;
  final int? maxLength;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final FormFieldValidator<String>? validate;
  final bool? enabled;
  final bool obscureText;
  final bool readOnly;
  final bool isPassword;
  final Color? labelColor;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onKeyUp;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: CustomOpenSansText(
            text: label,
            textColor: labelColor ?? Colors.black,
            textSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          height: 45,
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          decoration: BoxDecoration(
            // color: Colors.grey.shade100,
            border: Border.all(color: borderColor ?? Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(3)),
          ),
          child: TextFormField(
            onChanged: onKeyUp,
            onEditingComplete: onEditingComplete,
            controller: controller,
            validator: validate,
            textInputAction: inputAction,
            keyboardType: keyboardType,
            maxLength: maxLength,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              fillColor: Colors.grey,
              contentPadding: const EdgeInsets.only(bottom: 11),
              hintText: placeholder,
              prefixIcon: prefixIcon,
              prefixText: prefixText,
              suffixText: suffixText,
              prefixStyle: const TextStyle(fontSize: 14, color: AppColor.black),
              hintStyle: const TextStyle(fontSize: 14),
              // border: InputBorder.none,
              // suffixIcon: suffixIcon,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 30,
                maxWidth: 24,
                minHeight: 20,
              ),
            ),
            readOnly: readOnly,
            enabled: enabled,
            cursorColor: AppColor.primaryColor,
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization,
            obscureText: obscureText,
          ),
        ),
      ],
    );
  }
}

class CustomIconTextField extends StatefulWidget {
  const CustomIconTextField({
    super.key,
    required this.textEditingController,
    this.textHint,
    this.icon,
    this.isPassword = false,
    this.suffixIcon,
    this.validate,
    this.onChanged,
    this.focusNode,
    this.inputFormatters,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.iconColor,
    this.inputAction,
  });

  final TextEditingController textEditingController;
  final String? textHint;
  final Function(String)? onChanged;
  final String? icon;
  final Color? iconColor;
  final bool isPassword;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validate;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;

  @override
  State<CustomIconTextField> createState() => _CustomIconTextFieldState();
}

class _CustomIconTextFieldState extends State<CustomIconTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isPassword;
  }

  void toggleObscure() {
    setState(() => isObscure = !isObscure);
  }

  @override
  Widget build(BuildContext context) {
    var bodyMedium = Theme.of(context).textTheme.bodyMedium;

    return TextFormField(
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      style: bodyMedium,
      validator: widget.validate,
      cursorColor: AppColor.black,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      textInputAction: widget.inputAction,
      // textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.grey[100]?.withOpacity(.05),

        border: OutlineInputBorder(
          // borderSide: BorderSide.none,
          borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          // borderSide: BorderSide.none,
          borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          // borderSide: BorderSide.none,
          borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
          borderRadius: BorderRadius.circular(10),
        ),

        hintText: widget.textHint,
        suffixIcon:
            !widget.isPassword
                ? widget.suffixIcon
                : Visibility(
                  visible: !widget.textHint!.contains('jk'),
                  child: IconButton(
                    onPressed: toggleObscure,
                    color: Colors.grey,
                    splashColor: Colors.transparent,
                    icon: Icon(
                      !isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 18,
                    ),
                  ),
                ),
        hintStyle: bodyMedium?.copyWith(color: Colors.black45),
        prefixIcon:
            widget.icon == null
                ? null
                : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    widget.icon!,
                    height: 17,
                    width: 17,
                    color: widget.iconColor,
                  ),
                ),
        contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      ),
    );
  }
}

class CustomGoogleLabelInputText extends StatelessWidget {
  const CustomGoogleLabelInputText({
    super.key,
    this.label,
    this.controller,
    this.hintText,
    this.counterText,
    this.maxLength,
    this.maxLines,
    this.minLines,
    required this.keyboardType,
    required this.inputAction,
    this.validate,
    this.enabled,
    this.obscureText = false,
    this.readOnly = false,
    this.required = false,
    this.labelColor,
    this.borderColor,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixIcon,
    this.prefixIcon,
    this.onKeyUp,
    this.fontStyle,
    this.fontWeight,
    this.apiKey,
    this.getPlaceDetailWithLatLng,
    this.itemClick,
    this.itemBuilder,
    this.focusNode,
    this.icon,
  });
  final String? icon;
  final String? label;
  final TextEditingController? controller;
  final String? hintText;
  final String? counterText;
  final String? apiKey;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final FormFieldValidator<String>? validate;
  final bool? enabled;
  final bool obscureText;
  final bool readOnly;
  final bool required;
  final Color? labelColor;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final Function(String)? onKeyUp;
  final ItemClick? itemClick;
  final GetPlaceDetailswWithLatLng? getPlaceDetailWithLatLng;
  final FocusNode? focusNode;

  // final Function(BuildContext, int, Prediction)? itemBuilder;
  final ListItemBuilder? itemBuilder;

  @override
  Widget build(BuildContext context) {
    var bodyMedium = Theme.of(context).textTheme.bodyMedium;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Row(
            children: [
              CustomOpenSansText(
                text: label!,
                textColor: labelColor ?? Colors.black,
                textSize: 12.sp,
                fontStyle: fontStyle,
                fontWeight: fontWeight,
              ),
              if (required)
                CustomOpenSansText(
                  text: "*",
                  textColor: AppColor.primaryColor,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
            ],
          ),
        GooglePlaceAutoCompleteTextField(
          boxDecoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
          ),
          textEditingController: controller ?? TextEditingController(),
          googleAPIKey: apiKey ?? "",
          focusNode: focusNode,
          validator: (value, context) {
            if (validate != null) {
              return validate!(value);
            }
            return null;
          },
          textStyle: bodyMedium ?? const TextStyle(color: Colors.black),
          inputDecoration: InputDecoration(
            filled: true,
            fillColor: AppColor.grey[100]?.withOpacity(.05),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
              borderRadius: BorderRadius.circular(10),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300, width: .9),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade300, width: .9),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade300, width: .9),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hintText,
            prefixIcon:
                prefixIcon ??
                (icon != null
                    ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        icon ?? "",
                        height: 17,
                        width: 17,
                      ),
                    )
                    : null),
            counterText: counterText,
            hintStyle: bodyMedium?.copyWith(color: Colors.black45),
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 30,
              maxWidth: 35,
              minHeight: 20,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 2.h,
              horizontal: 5.w,
            ),
          ),
          debounceTime: 800,
          showError: true,
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: getPlaceDetailWithLatLng,
          itemClick: itemClick,
          itemBuilder:
              itemBuilder ??
              (context, index, prediction) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade100),
                    ),
                  ),
                  child: Text(prediction.description ?? "", style: bodyMedium),
                );
              },
        ),
      ],
    );
  }
}

class CustomDropdownItem extends StatelessWidget {
  final String suggestion;

  // final VoidCallback onTap;

  const CustomDropdownItem({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            Column(
              children: [
                // SvgPicture.asset(AppAssets.suggestionPin),
                // YMargin(8.h),
                // const CustomOpenSansText(text: "13KM")
              ],
            ),
            SizedBox(width: 22.w),
            Expanded(
              child: Text(
                suggestion,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            SizedBox(width: 22.w),
            // SvgPicture.asset(AppAssets.suggestionArrow),
          ],
        ),
      ),
    );
  }
}
