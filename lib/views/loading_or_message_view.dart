import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/constants/app_color.dart';

class LoadingOrMessageView extends StatefulWidget {
  final bool isLoading;
  final String message;
  final String loadingMessage;
  final double? height;
  final double? width;
  final Widget? child;
  final Widget? extraChild;
  final bool showChild;
  final bool expanded;
  final bool dimBackgroundWhenLoading;

  const LoadingOrMessageView({
    super.key,
    this.isLoading = false,
    this.expanded = false,
    this.message = "",
    this.loadingMessage = "",
    this.height,
    this.width,
    this.child,
    this.showChild = true,
    this.extraChild,
    this.dimBackgroundWhenLoading = false,
  });

  @override
  State<LoadingOrMessageView> createState() => _LoadingOrMessageViewState();
}

class _LoadingOrMessageViewState extends State<LoadingOrMessageView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color:
            widget.isLoading && widget.dimBackgroundWhenLoading
                ? Colors.black.withOpacity(0.4)
                : Colors.transparent,
        height: widget.height ?? (widget.expanded ? double.infinity : null),
        width: widget.width ?? (widget.expanded ? double.infinity : null),
        alignment:
            (widget.expanded || widget.height != null)
                ? Alignment.center
                : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (widget.showChild && widget.child != null) widget.child!,
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.isLoading) ...[
                  LoadingAnimationWidget.discreteCircle(
                    size: 20,
                    color: AppColor.primaryColor,
                    secondRingColor: AppColor.secondaryColor,
                    thirdRingColor: AppColor.accent,
                  ),
                  if (widget.loadingMessage.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      widget.loadingMessage,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.lightBlack,
                      ),
                    ),
                  ],
                ] else ...[
                  if (widget.message.isNotEmpty) ...[
                    Text(
                      widget.message,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.lightBlack,
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ],
        ),
        // !widget.isLoading && widget.showChild
        //     ? widget.child
        //     : Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         if (widget.isLoading) ...[
        //           LoadingAnimationWidget.discreteCircle(
        //             size: 20,
        //             color: AppColor.primaryColor,
        //             secondRingColor: AppColor.secondaryColor,
        //             thirdRingColor: AppColor.accent,
        //           ),
        //           if (widget.loadingMessage.isNotEmpty) ...[
        //             const SizedBox(height: 6),
        //             Text(
        //               widget.loadingMessage,
        //               style: const TextStyle(
        //                 fontSize: 16,
        //                 color: AppColors.lightBlack,
        //               ),
        //             ),
        //           ],
        //         ] else ...[
        //           if (widget.message.isNotEmpty) ...[
        //             Text(
        //               widget.message,
        //               style: const TextStyle(
        //                 fontSize: 16,
        //                 color: AppColors.lightBlack,
        //               ),
        //             ),
        //           ],
        //         ],
        //       ],
        //     ),
      ),
    );
  }
}
