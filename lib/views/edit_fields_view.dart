// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/action_button_with_icon.dart';
import 'package:looking2hire/components/dialog_container.dart';
import 'package:looking2hire/extensions/scroll_controller_extensions.dart';
import 'package:looking2hire/reuseable/extensions/string_extensions.dart';

class EditFieldsView extends StatefulWidget {
  final String title;
  final String? hint;
  final List<String>? options;
  final Function(List<String> options) onSave;
  const EditFieldsView({
    super.key,
    required this.title,
    this.hint,
    this.options,
    required this.onSave,
  });

  @override
  State<EditFieldsView> createState() => _EditFieldsViewState();
}

class _EditFieldsViewState extends State<EditFieldsView> {
  List<String> options = [];
  List<TextEditingController> controllers = [];
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (widget.options != null) {
      options.addAll(widget.options!);
      controllers.addAll(
        options.map((option) => TextEditingController(text: option)),
      );
    }
  }

  void saveDetails() {
    widget.onSave(
      controllers
          .where((controller) => controller.text.trim().isNotEmpty)
          .map((controller) => controller.text.trim())
          .toList(),
    );
  }

  void addOption() {
    options.add("");
    controllers.add(TextEditingController());
    scrollController.scrollToBottom();
    setState(() {});
  }

  void removeOption(int index) {
    options.removeAt(index);
    controllers.removeAt(index);
    setState(() {});
  }

  String getHintText() {
    final title = widget.title.toLowerCase().capitalize;
    return title.endsWith("ies")
        ? "${title.substring(0, title.length - 3)}y"
        : title.endsWith("s")
        ? title.substring(0, title.length - 1)
        : title;
  }

  @override
  void dispose() {
    scrollController.dispose();
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      title: "Edit ${widget.title}",
      hint:
          "Update the ${widget.title.toLowerCase()} details and save changes.",
      actions: [
        ActionButtonWithIcon(title: "Add", onPressed: addOption),
        ActionButtonWithIcon(title: "Save Changes", onPressed: saveDetails),
      ],
      isScrollable: false,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(options.length, (index) {
            //final option = options[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CircleAvatar(
                    radius: 2,
                    backgroundColor: AppColors.lighterBlack,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controllers[index],
                    maxLines: null,
                    minLines: 1,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      border: InputBorder.none,
                      hintText: getHintText(),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lighterBlack.withOpacity(0.5),
                      ),
                    ),
                    // onChanged: (text) {
                    //   options[index] = text;
                    //   setState(() {});
                    // },
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lighterBlack,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => removeOption(index),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  color: AppColors.lighterBlack,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
