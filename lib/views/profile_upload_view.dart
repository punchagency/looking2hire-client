import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/reuseable/widgets/round_image.dart';

class ProfileUploadView extends StatefulWidget {
  final String imageUrl;
  final VoidCallback onRemove;
  final void Function(String filePath) onSelect;
  const ProfileUploadView({
    super.key,
    required this.imageUrl,
    required this.onRemove,
    required this.onSelect,
  });

  @override
  State<ProfileUploadView> createState() => _ProfileUploadViewState();
}

class _ProfileUploadViewState extends State<ProfileUploadView> {
  String _filePath = "";

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      //_imagePath = image.path;
      _filePath = image.path;
      widget.onSelect(_filePath);
    }
    setState(() {});
  }

  void removeImage() {
    _filePath = "";
    widget.onRemove();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: SizedBox(
            height: 130,
            width: 110,
            child: Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: RoundedImage(
                    size: 110,
                    imageUrl: widget.imageUrl,
                    filePath: _filePath,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: SvgPicture.asset(AppAssets.camera),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: selectImage,
              icon: SvgPicture.asset(AppAssets.edit, width: 18, height: 18),
            ),
            IconButton(
              onPressed: removeImage,
              icon: SvgPicture.asset(
                AppAssets.trash,
                color: Colors.red,
                width: 18,
                height: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
