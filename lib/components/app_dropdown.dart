import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';

class AppDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String?)? onChanged;
  final String? hintText;
  final double? width;
  final double? height;
  final bool isInputField;
  final String? icon;

  const AppDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.hintText,
    this.width,
    this.height,
    this.isInputField = false,
    this.icon,
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

    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: DropdownButtonFormField<String>(
        style: bodyMedium,
        dropdownColor: Colors.white,

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
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightBlack,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
