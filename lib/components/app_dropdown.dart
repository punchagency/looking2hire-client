import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';

class AppDropdown extends StatefulWidget {
  final List<String> items;
  final List<String>? icons;
  final String? selectedItem;
  final Function(String?)? onChanged;
  final String? hintText;
  final String? label;
  final double? width;
  final double? height;
  final bool isInputField;
  final String? icon;
  final Color? iconColor;
  final FocusNode? focusNode;

  const AppDropdown({
    super.key,
    required this.items,
    this.icons,
    this.selectedItem,
    required this.onChanged,
    this.hintText,
    this.label,
    this.width,
    this.height,
    this.isInputField = false,
    this.icon,
    this.iconColor,
    this.focusNode,
  });

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? selectedItem;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedItem =
        (widget.selectedItem ?? "").isEmpty
            ? widget.items.firstOrNull
            : widget.selectedItem;
    var bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final labelText = widget.label ?? widget.hintText ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText.isNotEmpty) ...[
          CustomRobotoText(
            text: labelText,
            textColor: Colors.black,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          const SizedBox(height: 4),
        ],
        SizedBox(
          height: widget.height,
          width: widget.width,
          child: DropdownButtonFormField<String>(
            style: bodyMedium,
            focusNode: widget.focusNode,
            dropdownColor: Colors.white,
            isExpanded: true,
            menuMaxHeight: 300,

            decoration:
                widget.isInputField
                    ? InputDecoration(
                      filled: true,
                      fillColor: AppColor.grey[100]?.withOpacity(.05),

                      border: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: .9,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: .9,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: .9,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      hintText: widget.hintText,

                      hintStyle:
                          !widget.isInputField
                              ? null
                              : bodyMedium?.copyWith(color: Colors.black45),
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
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 2.h,
                        horizontal: 10.w,
                      ),
                    )
                    : InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
            // padding: ,
            icon: SvgPicture.asset(AppAssets.dropdownArrow),
            // isExpanded: true,
            // borderRadius: BorderRadius.circular(15),
            value: selectedItem,
            onChanged: widget.onChanged,

            items:
                widget.items.map((String item) {
                  final index = widget.items.indexOf(item);
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        if (widget.icons != null) ...[
                          SvgPicture.asset(widget.icons![index]),
                          SizedBox(width: 10),
                        ],
                        Text(
                          item,
                          style:
                              widget.isInputField
                                  ? bodyMedium
                                  : const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.lightBlack,
                                  ),
                          // style: const TextStyle(
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.w400,
                          //   color: AppColors.lightBlack,
                          // ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
