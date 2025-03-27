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

  const LoadingOrMessageView({
    super.key,
    this.isLoading = false,
    this.message = "",
    this.loadingMessage = "",
    this.height,
    this.width,
    this.child,
    this.showChild = true,
    this.extraChild,
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
        height: widget.height ?? double.infinity,
        width: widget.width ?? double.infinity,
        alignment: Alignment.center,
        child:
            !widget.isLoading && widget.showChild
                ? widget.child
                : Column(
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
      ),
    );
  }
}
