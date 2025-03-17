import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/constants/app_assets.dart';

class AppDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final Function(String?)? onChanged;

  const AppDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 150,
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        decoration: InputDecoration(
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
        icon: SvgPicture.asset(AppAssets.dropdownArrow),
        // isExpanded: true,
        borderRadius: BorderRadius.circular(15),
        value: selectedItem,
        onChanged: onChanged,
        items:
            items.map((String item) {
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
